module Coloration

  module Color

    # A colour object representing YIQ (NTSC) colour encoding.
    class YIQ

      # @param red []
      # @param green []
      # @param blue []
      # @return [Coloration::Color::YIQ]
      def self.from_rgb(red, green, blue)
        y = (red * 0.299) + (green *  0.587) + (blue *  0.114)
        i = (red * 0.596) + (green * -0.275) + (blue * -0.321)
        q = (red * 0.212) + (green * -0.523) + (blue *  0.311)

        new(y, i, q)
      end

      # @params y [Float] Brightness
      # @params i [Float] In-phase
      # @params q [Float] Quadrature
      # @return [Coloration::Color::YIQ]
      def initialize(y = 0.0, i = 0.0, q = 0.0)
        @y = Coloration::Normalize[y]
        @i = Coloration::Normalize[i]
        @q = Coloration::Normalize[q]
      end

      # Compares the other colour to this one. The other colour will be
      # converted to YIQ before comparison, so the comparison between a YIQ
      # colour and a non-YIQ colour will be approximate and based on the other
      # colour's #to_yiq conversion. If there is no #to_yiq conversion, this
      # will raise an exception. This will report that two YIQ values are
      # equivalent if all component colours are within 1e-4 (0.0001) of each
      # other.
      #
      # @param other []
      # @return [Boolean]
      def ==(other)
        other.is_a?(Coloration::Color::YIQ) &&
        ((@y - other.y).abs <= 1e-4) && ((@i - other.i).abs <= 1e-4) &&
        ((@q - other.q).abs <= 1e-4)
      end

      # @return [Coloration::Color::YIQ]
      def to_yiq
        self
      end

      # @return [Float]
      def brightness
        @_y ||= Coloration::Normalize[@y]
      end
      alias_method :y, :brightness

      # @return [Float]
      def in_phase
        @_i ||= Coloration::Normalize[@i]
      end
      alias_method :i, :in_phase

      # @return [Float]
      def quadrature
        @_q ||= Coloration::Normalize[@q]
      end
      alias_method :q, :quadrature

      # @param value []
      # @return [Float]
      def brightness=(value)
        @_y = @y = Coloration::Normalize[value]
      end
      alias_method :y=, :brightness=

      # @param value []
      # @return [Float]
      def in_phase=(value)
        @_i = @i = Coloration::Normalize[value]
      end
      alias_method :i=, :in_phase=

      # @param value []
      # @return [Float]
      def quadrature=(value)
        @_q = @q = Coloration::Normalize[value]
      end
      alias_method :q=, :quadrature=

    end # YIQ

  end # Color

end # Coloration
