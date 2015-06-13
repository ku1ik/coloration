module Coloration

  module Converters

    module TextMate

      class Vim

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
          'Vim'
        end

        # @return [String]
        def to_type
          'vim'
        end

        # @return [Class]
        def writer
          Coloration::Writers::Vim
        end

      end # Vim

    end # TextMate

  end # Converters

end # Coloration
