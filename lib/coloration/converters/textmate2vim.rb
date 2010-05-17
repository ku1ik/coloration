module Coloration
  module Converters
    class Textmate2VimConverter < AbstractConverter
      include Readers::TextMateThemeReader
      include Writers::VimThemeWriter
    end
  end
end
