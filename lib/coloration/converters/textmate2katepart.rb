module Coloration

  module Converters

    class Textmate2KatePartConverter < AbstractConverter

      include Readers::TextMateThemeReader
      include Writers::KatePartThemeWriter

      # @return [String]
      def in_theme_type
        'Textmate'
      end

      # @return [String]
      def in_theme_ext
        'tmTheme'
      end

      # @return [String]
      def out_theme_type
        'KatePart'
      end

      # @return [String]
      def out_theme_ext
        'txt'
      end

    end # Textmate2KatePartConverter

  end # Converters

end # Coloration
