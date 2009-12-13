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
      theme.ui = settings.delete_at(0)["settings"]
      theme.ui["line_highlight"] = theme.ui.delete("lineHighlight")
      theme.ui.keys.each do |key|
        theme.ui[key] = Color::RGB.from_html(theme.ui[key])
      end
      # set items
      theme.items = SelectorHash.new
      settings.each do |rule|
        selectors = rule["scope"]
        style = rule["settings"]
        selectors.split(",").each do |selector|
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
          theme.items[selector.strip] = Style.new(style)
        end
      end
      
#       require 'pp'
#       pp @ui
#       pp @items
      theme
    end
    
    def to_s
      raise RuntimeError.new("Not implemented yet")
    end
    
#     def self.convert(theme)
#       theme.name = @name
#       theme.normal = { :foreground => normalize_color(@src_theme[:foreground]) }
#       theme.background = normalize_color(@src_theme[:background])
#       theme.caret = normalize_color(@src_theme[:caret])
#       theme.selection = normalize_color(@src_theme[:selection], theme.background)
#       theme.eol_marker = normalize_color(@src_theme[:invisibles], theme.background)
#       theme.line_highlight = normalize_color(@src_theme[:lineHighlight], theme.background)
#       # #foo
#       theme.comment = @src_theme["comment"]
#       # "foo"
#       theme.string = @src_theme["string"]
#       # :foo
#       theme.label = @src_theme["constant"]
#       # 123
#       theme.number = @src_theme["constant.numeric"]
#       # class, def, if, end
#       theme.keyword = @src_theme["keyword.control"]
#       # true, false, nil
#       theme.keyword2 = @src_theme["constant.language"]
#       # @foo
#       theme.variable = @src_theme["variable"] || @src_theme["variable.other"]
#       # = < + -
#       theme.operator = @src_theme["keyword.operator"]
#       # def foo, maybe MyClass??
#       theme.function = @src_theme["entity.name.function"]
#       # /jola/
#       theme.regexp = @src_theme["string.regexp"]
#       # UserSpace, CGI, JOLA_MISIO
#       #theme.constant = @src_theme["support"]
#       # <div>
#       theme.markup = @src_theme["meta.tag"]
#     end
    
#     def self.blend(col_a, col_b, alpha)
#       newcol = []
#       [0,1,2].each do |i|
#         newcol[i] = (1.0 - alpha) * col_a[i] + alpha * col_b[i]
#       end
#       newcol
#     end
#     
#     def self.color_to_triplet(color)
#       color.slice(1,6).scan(/.{2}/).map { |x| x.hex.to_f / 255.0 }
#     end
#     
#     def self.normalize_color(color, bg=nil)
#       alpha = color.slice(7,9).to_i(16)
#       if bg && (1..254).include?(alpha)
#         bg = color_to_triplet(bg)
#         color = color_to_triplet(color)
#         result = blend(bg, color, alpha.to_f / 255.0)
#         value = "%02x%02x%02x" % result.map { |x| (x*255.0).to_i }
#       else
#         value = color.slice(1,6).downcase
#       end
#       "\##{value}"
#     end
  end

end
