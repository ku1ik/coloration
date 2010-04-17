module Coloration
  module Converters
    class AbstractConverter
      attr_accessor :name, :ui, :items

      def files
        @files ||= get_files
      end

      def print
        files.each do |filename, content|
          puts "file: #{filename}\n\n"
          puts "#{content}\n"
        end
      end

      def write
        files.each do |filename, content|
          File.open(filename.gsub(/[^A-Za-z0-9._\s-]/, "-"), "w") do |f|
            f.write content
          end
        end
      end
    end
  end
end
