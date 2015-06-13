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
        def from_html(html_colour)
          html_colour = html_colour.gsub(%r{[#;]}, '')

          case html_colour.size
          when 0
            return
          when 3
            colours = html_colour.scan(%r{[0-9A-Fa-f]}).map { |el| (el * 2).to_i(16) }
          when 6
            colours = html_colour.scan(%r<[0-9A-Fa-f]{2}>).map { |el| el.to_i(16) }
          else
            raise ArgumentError
          end

          Color::RGB.new(*colours)
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
        other = other.to_rgb
        other.kind_of?(Color::RGB) and
        ((@r - other.r).abs <= 1e-4) and
        ((@g - other.g).abs <= 1e-4) and
        ((@b - other.b).abs <= 1e-4)
      end

      # Returns the brightness value for a colour, a number between 0..1.
      # Based on the Y value of YIQ encoding, representing luminosity, or
      # perceived brightness.
      #
      # This may be modified in a future version of color-tools to use the
      # luminosity value of HSL.
      def brightness
        to_yiq.y
      end

      # Returns the YIQ (NTSC) colour encoding of the RGB value.
      def to_yiq
        y = (@r * 0.299) + (@g *  0.587) + (@b *  0.114)
        i = (@r * 0.596) + (@g * -0.275) + (@b * -0.321)
        q = (@r * 0.212) + (@g * -0.523) + (@b *  0.311)
        Coloration::Color::YIQ.from_fraction(y, i, q)
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
      def mix_with(mask, opacity)
        opacity /= 100.0
        rgb = self.dup

        rgb.r = (@r * opacity) + (mask.r * (1 - opacity))
        rgb.g = (@g * opacity) + (mask.g * (1 - opacity))
        rgb.b = (@b * opacity) + (mask.b * (1 - opacity))

        rgb
      end

      attr_accessor :r, :g, :b
      remove_method :r=, :g=, :b= ;

      # Normalize red value.
      def r=(rr)
        rr = 1.0 if rr > 1
        rr = 0.0 if rr < 0

        @r = rr
      end

      # Normalize green value.
      def g=(gg)
        gg = 1.0 if gg > 1
        gg = 0.0 if gg < 0

        @g = gg
      end

      # Normalize blue value.
      def b=(bb)
        bb = 1.0 if bb > 1
        bb = 0.0 if bb < 0

        @b = bb
      end

    end # RGB

  end # Color

end # Coloration
