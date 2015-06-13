module Coloration

  class CLIParser

    # @param reader []
    # @param argv [Array<String>]
    # @return [void]
    # @todo
    def self.process(reader, argv = ARGV)
      new(reader, argv).process
    end

    # @param reader []
    # @param argv [Array<String>]
    # @return [Coloration::CLIParser]
    # @todo
    def initialize(reader, argv = ARGV)
      @reader = reader
      @argv   = argv
    end

    # @return [void]
    # @todo
    def process
      return usage unless arguments?

      Coloration::Parser.process(destination: destination,
                                 reader:      reader,
                                 source:      source,
                                 writer:      writer)

    rescue Coloration::InvalidThemeError
      error

    end

    private

    # @return [Boolean]
    def arguments?
      argv.any?
    end

    # @return [Array<String>|Array]
    def argv
      Array(@argv)
    end

    # @return [String]
    def destination
      argv[1] || source.gsub(/\.#{from_type}$/, ".#{to_type}")
    end

    # @return [void]
    # @todo
    def error
      message = 'Error: The source file does not appear to be an XML plist ' \
                'file containing a TextMate theme.'

      Coloration.log(message)
      STDERR.puts message

      message
    end

    # @return [String]
    def from
      reader.from
    end

    # @return [String]
    def from_type
      reader.from_type
    end

    # @return [void]
    def reader
      fail Coloration::NoReaderError,
        'No reader was specified.' unless @reader

      @reader
    end

    # @return [String]
    def source
      argv[0]
    end

    # @return [String]
    def to
      reader.to
    end

    # @return [String]
    def to_type
      reader.to_type
    end

    # @return [void]
    # @todo
    def usage
      message = "Usage: #{File.basename($0)} <in #{from} theme> " \
                "[out #{to} theme]"

      Coloration.log(message)
      STDOUT.puts message

      message
    end

    # @return [Class]
    # @todo
    def writer
      reader.writer
    end

  end # CLIParser

end # Coloration
