module Coloration
  module Converters
    class Textmate2KatePartConverter < AbstractConverter
      include Readers::TextMateThemeReader
      include Writers::KatePartThemeWriter
    end
  end
end
