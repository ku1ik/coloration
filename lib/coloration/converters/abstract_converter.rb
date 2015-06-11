module Coloration

  module Converters

    class AbstractConverter

      attr_accessor :name, :ui, :items, :input, :result

      class << self
        attr_reader :in_theme_type
      end

      # @return [void]
      # @todo
      def self.process_cmd_line
        new(ARGV).process
      end

      # @param []
      # @return [void]
      # @todo
      def initialize(argv = ARGV)
        @argv = argv
      end

      # @return [void]
      # @todo
      def process
        return usage_message unless argv.any?

        read

        parse_input

        build_result

        write

      rescue Coloration::Readers::TextMateThemeReader::InvalidThemeError
        invalid_theme_message

      end

      protected

      # @!attribute [r] argv
      # @return [Array<String>]
      attr_reader :argv

      # @!attribute [r] converter
      # @return [Class]
      attr_reader :converter

      # @return [String]
      def comment_message
        "Converted from #{in_theme_type} theme #{name} using Coloration " \
        "v#{VERSION} (http://github.com/sickill/coloration)"
      end

      private

      # @return [void]
      # @todo
      def in_theme_filename
        argv[0]
      end

      # @return [void]
      # @todo
      def invalid_theme_message
        STDERR.puts "Err: given file doesn't look like xml plist file " \
                    "containing Textmate theme"
      end

      # @return [void]
      # @todo
      def out_theme_filename
        argv[1] || in_theme_filename.
          gsub(/\.#{in_theme_ext}$/, ".#{out_theme_ext}")
      end

      # @return [void]
      # @todo
      def read
        @input = File.read(in_theme_filename)
      end

      # @return [void]
      # @todo
      def usage_message
        STDOUT.puts "#{File.basename($0)} <in #{in_theme_type} theme> [out " \
                    "#{out_theme_type} theme]"
      end

      # @return [void]
      # @todo
      def write
        @output = File.open(out_theme_filename, 'w') { |f| f.write(result) }
      end

    end # AbstractConverter

  end # Converters

end # Coloration
