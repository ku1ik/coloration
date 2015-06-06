module Coloration

  module Writers

    module AbstractWriter

      # @param line [String]
      # @return [Array<String>]
      def add_line(line = '')
        (@lines ||= []) << line
      end

    end # AbstractWriter

  end # Writers

end # Coloration
