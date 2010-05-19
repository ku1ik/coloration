module Coloration
  module Converters
    class Textmate2JEditConverter < AbstractConverter
      @in_theme_type = "Textmate"
      @in_theme_ext = "tmTheme"
      @out_theme_type = "JEdit"
      @out_theme_ext = "jedit-scheme"
      include Readers::TextMateThemeReader
      include Writers::JEditThemeWriter
    end
  end
end
