module Coloration
  module Converters
    class Textmate2VimConverter < AbstractConverter
      @in_theme_type = "Textmate"
      @in_theme_ext = "tmTheme"
      @out_theme_type = "Vim"
      @out_theme_ext = "vim"
      include Readers::TextMateThemeReader
      include Writers::VimThemeWriter
    end
  end
end
