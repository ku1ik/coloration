module Coloration

  module Color

    # A colour object representing YIQ (NTSC) colour encoding.
    class YIQ

      # Creates a YIQ colour object from fractional values 0 .. 1.
      #
      #   Color::YIQ.new(0.3, 0.2, 0.1)
      def self.from_fraction(y = 0, i = 0, q = 0)
        color = Coloration::Color::YIQ.new
        color.y = y
        color.i = i
        color.q = q
        color
      end

      # Creates a YIQ colour object from percentages 0 .. 100.
      #
      #   Color::YIQ.new(10, 20, 30)
      def initialize(y = 0, i = 0, q = 0)
        @y = y / 100.0
        @i = i / 100.0
        @q = q / 100.0
      end

      # Compares the other colour to this one. The other colour will be
      # converted to YIQ before comparison, so the comparison between a YIQ
      # colour and a non-YIQ colour will be approximate and based on the other
      # colour's #to_yiq conversion. If there is no #to_yiq conversion, this
      # will raise an exception. This will report that two YIQ values are
      # equivalent if all component colours are within 1e-4 (0.0001) of each
      # other.
      def ==(other)
        other = other.to_yiq
        other.kind_of?(Coloration::Color::YIQ) and
        ((@y - other.y).abs <= 1e-4) and
        ((@i - other.i).abs <= 1e-4) and
        ((@q - other.q).abs <= 1e-4)
      end

      def to_yiq
        self
      end

      def brightness
        @y
      end

      attr_reader :y, :i, :q

      def y=(yy)
        @y = Coloration::Normalize[yy]
      end

      def i=(ii)
        @i = Coloration::Normalize[ii]
      end

      def q=(qq)
        @q = Coloration::Normalize[qq]
      end

    end # YIQ

  end # Color

end # Coloration
