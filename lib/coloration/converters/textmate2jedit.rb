module Coloration

  module Converters

    class Textmate2JEditConverter < AbstractConverter

      include Readers::TextMateThemeReader
      include Writers::JEditThemeWriter

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
        'JEdit'
      end

      # @return [String]
      def out_theme_ext
        'jedit-scheme'
      end

    end # Textmate2JEditConverter

  end # Converters

end # Coloration
