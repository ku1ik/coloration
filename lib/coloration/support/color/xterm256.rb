module Coloration

  module Color

    class XTerm256

      # @param c []
      # @return [Fixnum]
      # @todo
      def self.rgb_to_xterm256(c)
        new(c).rgb_to_xterm256
      end

      # @param c []
      # @return [Coloration::Color::XTerm256]
      # @todo
      def initialize(c)
        @c = c
      end

      # @return [Fixnum]
      def rgb_to_xterm256
        return 0  if actual_red   == 0 &&
                     actual_green == 0 &&
                     actual_blue  == 0
        return 15 if actual_red   == 255 &&
                     actual_green == 255 &&
                     actual_blue  == 255

        all = greys + colors
        len = colors.size

        r = nearest(actual_red, all)
        g = nearest(actual_green, all)
        b = nearest(actual_blue, all)

        if r == g && g == b && (i = greys.index(r))
          n = len * len * len + i

        else
          r = nearest(actual_red)
          g = nearest(actual_green)
          b = nearest(actual_blue)

          n = colors.index(r) * len * len +
              colors.index(g) * len +
              colors.index(b)

        end

        16 + n
      end

      protected

      # @!attribute [r] c
      # @return [void]
      attr_reader :c

      private

      # @return [Fixnum]
      def actual_red
        @actual_red ||= (c.r * 255.0).to_i
      end

      # @return [Fixnum]
      def actual_green
        @actual_green ||= (c.g * 255.0).to_i
      end

      # @return [Fixnum]
      def actual_blue
        @actual_blue ||= (c.b * 255.0).to_i
      end

      def all
        colors + greys
      end

      # @return [Array<Fixnum>]
      def colors
        [0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF]
      end

      # @return [Array<Fixnum>]
      def greys
        [0x08, 0x12, 0x1C, 0x26, 0x30, 0x3A,
         0x44, 0x4E, 0x58, 0x62, 0x6C, 0x76,
         0x80, 0x8A, 0x94, 0x9E, 0xA8, 0xB2,
         0xBC, 0xC6, 0xD0, 0xDA, 0xE4, 0xEE]
       end

      # @param v []
      # @return [void]
      # @todo
      def nearest(v)
        0.upto(colors.size - 2) do |i|
          return colors[i] if v <= (colors[i] + colors[i+1]) / 2
        end

        colors.last
      end

    end # XTerm256

  end # Color

end # Coloration
