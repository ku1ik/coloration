module Coloration

  module Converters

    module TextMate

      # Provides writer for KatePart files.
      class KatePart

        # @return [String]
        def from
          'TextMate'
        end

        # @return [String]
        def from_type
          'tmTheme'
        end

        # @return [String]
        def to
          'KatePart'
        end

        # @return [String]
        def to_type
          'txt'
        end

        # @return [Class]
        def writer
          Coloration::Writers::KatePart
        end

      end # KatePart

    end # TextMate

  end # Converters

end # Coloration
