module Coloration

  module Converters

    module TextMate

      class JEdit

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
          'JEdit'
        end

        # @return [String]
        def to_type
          'jedit-scheme'
        end

        # @return [Class]
        def writer
          Coloration::Writers::JEdit
        end

      end # JEdit

    end # Converters

  end # TextMate

end # Coloration
