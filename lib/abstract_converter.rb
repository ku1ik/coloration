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

      def write(dst)
#        add_comment "#{self.name} theme for #{self.class.editor_name}"
#        add_comment "Generated from #{@original_theme.class.editor_name} theme with Coloration (http://github.com/sickill/coloration)\n"
        print
#        files.each do |filename, content|
#        end
      end
    end
  end
end
