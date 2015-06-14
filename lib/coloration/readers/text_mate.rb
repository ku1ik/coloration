module Coloration

  module Readers

    class TextMate

      extend Forwardable

      def_delegators :converter, :writer

      # @!attribute [r] converter
      # @return [void]
      # @todo
      attr_reader :converter

      # @!attribute [rw] items
      # @return [void]
      # @todo
      attr_accessor :items

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
        @items     = nil
      end

      # @return [void]
      # @todo
      def parse
        ui.each do |key, value|
          ui[key] = Coloration::Color::RGBA.from_html(value, bg) if value.start_with?('#')
        end
        ui['background'] = bg

        @items ||= Coloration::ItemsLookup.new(rules)
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

      private

      # @return [void]
      # @todo
      def bg
        @_bg ||= Coloration::Color::RGB.from_html(ui_background)
      end

      def input
        return @input unless @input.nil? || @input.empty?

        fail Coloration::NoSourceError, 'No source file was specified.'
      end

      # @return [void]
      # @todo
      def rules
        items = {}
        settings.each do |rule|
          selectors = rule['scope']
          style     = rule['settings']

          if font_style = style.delete('fontStyle')
            style[:bold] = true if font_style.include?('bold')

            style[:italic] = true if font_style.include?('italic')

            style[:underline] = true if font_style.include?('underline')
          end

          style = Coloration::Style.new(style, bg)

          selectors.split(',').each do |selector|
            items[selector.strip] = style
          end unless selectors.blank? || style.blank?
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
