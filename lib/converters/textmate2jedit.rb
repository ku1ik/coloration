module Coloration
  module Converters
    class Textmate2JEditConverter < AbstractConverter
      include Readers::TextMateThemeReader
      include Writers::JEditThemeWriter
    end
  end
end
