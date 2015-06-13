module Coloration

  module Readers

    class TextMateReader

      # @!attribute [r] converter
      # @return [void]
      # @todo
      attr_reader  :converter
      alias_method :reader, :converter

      # @param input []
      # @param converter []
      # @return [void]
      # @todo
      def self.parse(input, converter)
        new(input, converter).parse
      end

      # @param input []
      # @param converter []
      # @return [Coloration::Readers::TextMate]
      def initialize(input, converter)
        @input     = input
        @converter = converter
      end

      # @return [void]
      # @todo
      def parse
        ui.each do |key, value|
          if value.start_with?('#')
            ui[key] = Color::RGBA.from_html(value, bg)
          end
        end
        ui['background'] = bg

        @items = ItemsLookup.new(items)
      end

      # @return [void]
      # @todo
      def name
        @name ||= tm_theme['name']
      end

      # @return [void]
      # @todo
      def ui
        @ui ||= settings.delete_at(0)['settings']
      end

      # @return [void]
      # @todo
      def writer
        converter.new.writer
      end

      private

      # @return [void]
      # @todo
      def bg
        @_bg ||= Color::RGB.from_html(ui_background)
      end

      def input
        return @input unless @input.nil? || @input.empty?

        fail Coloration::NoSourceError, 'No source file was specified.'
      end

      # @return [void]
      # @todo
      def items
        items = {}
        settings.each do |rule|
          selectors = rule['scope']
          style     = rule['settings']

          if font_style = style.delete('fontStyle')
            style[:bold] = true if font_style.include?('bold')

            style[:italic] = true if font_style.include?('italic')

            style[:underline] = true if font_style.include?('underline')
          end

          style = Style.new(style, bg)

          unless selectors.blank? || style.blank?
            selectors.split(',').each do |selector|
              items[selector.strip] = style
            end
          end
        end
      end

      # @return [void]
      # @todo
      def settings
        tm_theme['settings']
      end

      # @return [Plist]
      def tm_theme
        @_tm_theme ||= Plist.parse_xml(input.gsub('ustring', 'string'))

      rescue
        fail Coloration::InvalidThemeError

      end
      alias_method :tm_theme?, :tm_theme

      # @return [void]
      # @todo
      def ui_background
        ui['background'][0..6]
      end

    end # TextMate

  end # Readers

end # Coloration
