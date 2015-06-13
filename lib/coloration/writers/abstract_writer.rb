module Coloration

  module Writers

    module AbstractWriter

      extend Forwardable

      def_delegators :converter, :ui, :items

      module ClassMethods

        # @param input []
        # @param converter []
        # @return [String]
        # @todo
        def translate(input, converter)
          new(input, converter).translate
        end

      end

      module InstanceMethods

        # @return [String]
        def comment_message
          "Converted from '#{converter.from}' theme " \
          "'#{converter.name}' using Coloration v#{VERSION} "  \
          "(http://github.com/sickill/coloration)"
        end

        # @param name [String]
        # @param style [String]
        # @raise RuntimeError
        # @return [String]
        def format_item(name, style)
          fail RuntimeError, "Style for '#{name}' is missing!" unless style

          "#{name}=#{format_style(style)}"
        end

        # @param line [String]
        # @return [Array<String>]
        def store(line = '')
          (@lines ||= []) << line
        end

        # @return [String]
        def retrieve
          @lines.join("\n")
        end

        private

        # @!attribute [r] reader
        # @return [void]
        # @todo
        attr_reader :reader

      end

      # When this module is included in a class, provide ClassMethods as class
      # methods for the class.
      #
      # @param klass [Class]
      # @return [void]
      def self.included(klass)
        klass.send(:extend, ClassMethods)
        klass.send(:include, InstanceMethods)
      end

    end # AbstractWriter

  end # Writers

end # Coloration
