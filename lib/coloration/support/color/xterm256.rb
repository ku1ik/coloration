module Coloration

  module Color

    class XTerm256

      # @param color []
      # @return [Fixnum]
      # @todo
      def self.rgb_to_xterm256(color)
        new(color).rgb_to_xterm256
      end

      # @param color []
      # @return [Coloration::Color::XTerm256]
      # @todo
      def initialize(color)
        @color = color
      end

      # @return [Fixnum]
      def rgb_to_xterm256
        return 0  if actual_red   == 0 &&
                     actual_green == 0 &&
                     actual_blue  == 0
        return 15 if actual_red   == 255 &&
                     actual_green == 255 &&
                     actual_blue  == 255

        r = nearest(actual_red)
        g = nearest(actual_green)
        b = nearest(actual_blue)

        len = colors.size

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

      # @!attribute [r] color
      # @return [void]
      attr_reader :color

      private

      # @return [Fixnum]
      def actual_red
        @actual_red ||= (color.r * 255.0).to_i
      end

      # @return [Fixnum]
      def actual_green
        @actual_green ||= (color.g * 255.0).to_i
      end

      # @return [Fixnum]
      def actual_blue
        @actual_blue ||= (color.b * 255.0).to_i
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
        0.upto(all.size - 2) do |i|
          return all[i] if v <= (all[i] + all[i + 1]) / 2
        end

        all.last
      end

    end # XTerm256

  end # Color

end # Coloration
