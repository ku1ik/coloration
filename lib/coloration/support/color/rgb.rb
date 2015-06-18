module Coloration

  module Color

    # An RGB colour object.
    class RGB

      class << self

        # Creates an RGB colour object from an HTML colour descriptor (e.g.,
        # <tt>"fed"</tt> or <tt>"#cabbed;"</tt>.
        #
        #   Color::RGB.from_html("fed")
        #   Color::RGB.from_html("#fed")
        #   Color::RGB.from_html("#cabbed")
        #   Color::RGB.from_html("cabbed")
        def from_html(html_colour = '')
          fail ArgumentError unless html_colour.is_a?(String)

          return nil if html_colour.nil? || html_colour.empty?

          html_colour = html_colour.to_s.gsub(/[#;]/, '')

          colours = case html_colour.size
                    when 0
                      return

                    when 3
                      html_colour.scan(/[0-9A-Fa-f]/).map { |el| (el * 2).to_i(16) }

                    when 6
                      html_colour.scan(/[0-9A-Fa-f]{2}/).map { |el| el.to_i(16) }

                    else
                      fail ArgumentError

                    end

          Coloration::Color::RGB.new(*colours)
        end

      end

      # Creates an RGB colour object from the standard range 0..255.
      #
      #   Color::RGB.new(32, 64, 128)
      #   Color::RGB.new(0x20, 0x40, 0x80)
      def initialize(r = 0, g = 0, b = 0)
        @r = r / 255.0
        @g = g / 255.0
        @b = b / 255.0
      end

      # Compares the other colour to this one. The other colour will be
      # converted to RGB before comparison, so the comparison between a RGB
      # colour and a non-RGB colour will be approximate and based on the other
      # colour's default #to_rgb conversion. If there is no #to_rgb
      # conversion, this will raise an exception. This will report that two
      # RGB colours are equivalent if all component values are within 1e-4
      # (0.0001) of each other.
      def ==(other)
        other.is_a?(Coloration::Color::RGB) &&
          ((@r - other.r).abs <= 1e-4) && ((@g - other.g).abs <= 1e-4) &&
          ((@b - other.b).abs <= 1e-4)
      end

      # Returns the brightness value for a colour, a number between 0..1.
      # Based on the Y value of YIQ encoding, representing luminosity, or
      # perceived brightness.
      #
      # This may be modified in a future version of color-tools to use the
      # luminosity value of HSL.
      def brightness
        to_yiq.brightness
      end

      # @return [Coloration::Color::RGB]
      def to_rgb
        self
      end

      # Returns the YIQ (NTSC) colour encoding of the RGB value.
      def to_yiq
        Coloration::Color::YIQ.from_rgb(@r, @g, @b)
      end

      # Present the colour as an HTML/CSS colour string.
      def html
        r = (@r * 255).round
        r = 255 if r > 255

        g = (@g * 255).round
        g = 255 if g > 255

        b = (@b * 255).round
        b = 255 if b > 255

        "#%02x%02x%02x" % [ r, g, b ]
      end

      # Mix the mask colour (which must be an RGB object) with the current
      # colour at the stated opacity percentage (0..100).
      #
      # @param mask [Coloration::Color::RGB]
      # @param opacity [Fixnum]
      def mix_with(mask, opacity)
        opacity /= 100.0

        Coloration::Color::RGB.new(
          (@r * opacity) + (mask.r * (1 - opacity)),
          (@g * opacity) + (mask.g * (1 - opacity)),
          (@b * opacity) + (mask.b * (1 - opacity))
        )
      end

      attr_reader :r, :g, :b

      # Normalize red value.
      def r=(rr)
        @r = Coloration::Normalize[rr]
      end

      # Normalize green value.
      def g=(gg)
        @g = Coloration::Normalize[gg]
      end

      # Normalize blue value.
      def b=(bb)
        @b = Coloration::Normalize[bb]
      end

    end # RGB

  end # Color

end # Coloration
