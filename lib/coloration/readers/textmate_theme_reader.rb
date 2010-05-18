require 'plist'
require 'textpow'

module Coloration
  module Readers
    module TextMateThemeReader

      def read(file_name)
        # parse TM theme
        tm_theme = Plist.parse_xml(File.read(file_name).gsub("ustring", "string"))
        self.name = tm_theme["name"]
        settings = tm_theme["settings"]
        # set ui properties
        self.ui = settings.delete_at(0)["settings"]
        bg = Color::RGB.from_html(ui["background"][0..6])
        ui.keys.each do |key|
          ui[key] = Color::RGBA.from_html(ui[key], bg)
        end
        ui["background"] = bg

        # set items
        self.items = {}
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
          style = Style.new(style, bg)
          unless selectors.blank? || style.blank?
            selectors.split(",").each do |selector|
              items[selector.strip] = style
            end
          end
        end
        self.items = ItemsProxy.new(items)
      end
    end

    class ItemsProxy
      def initialize(items)
        @items = items
        @score_manager = Textpow::ScoreManager.new
      end

      def [](key)
        best = nil
        best_score = 0
        @items.keys.each do |s|
          score = @score_manager.score(s, key)
          if score > best_score
            best_score, best = score, s
          end
        end
        best && @items[best]
      end
    end
  end

end
