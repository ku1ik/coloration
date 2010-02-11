module Coloration
  module Converters
    class Textmate2NetbeansConverter < AbstractConverter
      include Readers::TextMateThemeReader
      include Writers::NetbeansThemeWriter
    end
  end
end
