module Coloration

  module Writers

    module AbstractWriter

      # @param line [String]
      # @return [Array<String>]
      def add_line(line = '')
        (@lines ||= []) << line
      end

      # @param name [String]
      # @param style [String]
      # @raise RuntimeError
      # @return [String]
      def format_item(name, style)
        raise RuntimeError, "Style for #{name} is missing!" unless style

        "#{name}=#{format_style(style)}"
      end

    end # AbstractWriter

  end # Writers

end # Coloration
