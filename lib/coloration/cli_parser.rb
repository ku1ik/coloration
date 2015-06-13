module Coloration

  class CLIParser

    extend Forwardable

    def_delegators :converter, :from,
                               :from_type,
                               :to,
                               :to_type,
                               :writer

    # @param converter []
    # @param argv [Array<String>]
    # @return [void]
    # @todo
    def self.process(converter, argv = ARGV)
      new(converter, argv).process
    end

    # @param converter []
    # @param argv [Array<String>]
    # @return [Coloration::CLIParser]
    # @todo
    def initialize(converter, argv = ARGV)
      @converter = converter
      @argv      = argv
    end

    # @return [void]
    # @todo
    def process
      return usage unless arguments?

      Coloration::Parser.process(destination: destination,
                                 converter:   converter,
                                 source:      source,
                                 writer:      writer)

    rescue Coloration::InvalidThemeError
      error

    end

    protected

    # @!attribute [r] converter
    # @return [void]
    # @todo
    attr_reader :converter

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

    # @return [void]
    def converter
      fail Coloration::NoConverterError,
        'No converter was specified.' unless @converter || @_converter

      @_converter ||= @converter
    end

    # @return [String]
    def source
      argv[0]
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

  end # CLIParser

end # Coloration
