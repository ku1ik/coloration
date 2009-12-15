require 'rexml/document'
require 'ostruct'
require 'plist'

module Coloration
  
  class TextMateTheme < Theme
    include REXML
    
    def self.editor_name
      "TextMate"
    end
    
    def self.parse(text)
      theme = new
      # parse TM theme
      tm_theme = Plist.parse_xml(text)
      settings = tm_theme["settings"]
      # set name
      theme.name = tm_theme["name"]
      # set ui properties
      theme.ui = SelectorHash.new(settings.delete_at(0)["settings"])
      theme.ui["line_highlight"] = theme.ui.delete("lineHighlight")
      bg = Color::RGB.from_html(theme.ui["background"])
      theme.ui.keys.each do |key|
        if (col = theme.ui[key]).size > 7 # we have color with alpha channel
          alpha = (100 * ((col[-2..-1]).to_i(16) / 255.0)).to_i
          color = Color::RGB.from_html(col[0..-3])
          color = color.mix_with(bg, alpha)
        else
          color = Color::RGB.from_html(col)
        end
        theme.ui[key] = color
      end
      # set items
      theme.items = SelectorHash.new
      settings.each do |rule|
        selectors = rule["scope"]
        style = rule["settings"]
        if font_style = style.delete("fontStyle")
          if font_style.include?("bold")
            style[:bold] = true
          end
          if font_style.include?("italic")
            style[:italic] = true
          end
          if font_style.include?("underline")
            style[:underline] = true
          end
        end
        style = Style.new(style)
        unless selectors.blank? || style.blank?
          selectors.split(",").each do |selector|
            theme.items[selector.strip] = style
          end
        end
      end
      theme
    end
    
    def to_s
      raise RuntimeError.new("Not implemented yet")
    end
    
  end

end
