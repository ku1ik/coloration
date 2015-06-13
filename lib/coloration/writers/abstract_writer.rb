module Coloration

  module Writers

    module AbstractWriter

      extend Forwardable

      def_delegators :converter, :ui, :items

      module ClassMethods

        # @param input [String]
        # @param converter []
        # @param from [String]
        # @param name [String]
        # @return [String]
        # @todo
        def translate(input, converter, from, name)
          new(input, converter, from, name).translate
        end

      end # ClassMethods

      module InstanceMethods

        # @return [String]
        def comment_message
          "Converted from '#{from}' theme '#{name}' using Coloration "\
          "v#{VERSION} (http://github.com/sickill/coloration)"
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

      end # InstanceMethods

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
