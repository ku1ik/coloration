module Coloration

  module Converters

    class Textmate2VimConverter < AbstractConverter

      include Readers::TextMateThemeReader
      include Writers::VimThemeWriter

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
        'Vim'
      end

      # @return [String]
      def out_theme_ext
        'vim'
      end

    end # Textmate2VimConverter

  end # Converters

end # Colorationnd
