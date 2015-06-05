module Coloration
  module Converters
    class AbstractConverter
      attr_accessor :name, :ui, :items, :input, :result

      class << self
        attr_reader :in_theme_type
      end

      def self.process_cmd_line
        if ARGV.size > 0
          begin
            converter = self.new
            converter.feed(File.read(ARGV[0]))
            out_filename = ARGV[1] || ARGV[0].gsub(/\.#{@in_theme_ext}$/, ".#{@out_theme_ext}")
            converter.convert!
            File.open(out_filename, "w") { |f| f.write(converter.result) }
          rescue Coloration::Readers::TextMateThemeReader::InvalidThemeError
            STDERR.puts "Err: given file doesn't look like xml plist file containing Textmate theme"
          end
        else
          puts "#{File.basename($0)} <in #{@in_theme_type} theme> [out #{@out_theme_type} theme]"
        end
      end

      def feed(data)
        self.input = data
      end

      def convert!
        parse_input
        build_result
      end

      protected

      def comment_text
        "Converted from #{self.class.in_theme_type} theme #{name} using Coloration v#{VERSION} (http://github.com/sickill/coloration)"
      end

      private

    end
  end
end
