module Coloration
  module Converters
    class AbstractConverter
      attr_accessor :name, :ui, :items, :input, :result

      def self.process_cmd_line
        if ARGV.size > 0
          converter = self.new
          converter.feed(File.read(ARGV[0]))
          out_filename = ARGV[1] || ARGV[0].gsub(/\.#{@in_theme_ext}$/, ".#{@out_theme_ext}")
          converter.convert!
          File.open(out_filename, "w") { |f| f.write(converter.result) }
        else
          puts "#{File.basename(__FILE__)} <in #{@in_theme_type} theme> [out #{@out_theme_type} theme]"
        end
      end

      def feed(data)
        self.input = data
      end

      def convert!
        parse_input
        build_result
      end
    end
  end
end
