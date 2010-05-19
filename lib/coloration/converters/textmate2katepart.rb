module Coloration
  module Converters
    class Textmate2KatePartConverter < AbstractConverter
      @in_theme_type = "Textmate"
      @in_theme_ext = "tmTheme"
      @out_theme_type = "KatePart"
      @out_theme_ext = "txt"
      include Readers::TextMateThemeReader
      include Writers::KatePartThemeWriter
    end
  end
end
