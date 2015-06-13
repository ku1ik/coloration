module Coloration

  class Parser

    # @!attribute [r] source
    # @return [void]
    # @todo
    attr_reader :source

    # @!attribute [r] destination
    # @return [void]
    # @todo
    attr_reader :destination

    # @param destination []
    # @param reader []
    # @param source []
    # @param writer []
    # @return [void]
    # @todo
    def self.process(destination:, reader:, source:, writer: nil)
      new(destination: destination,
          reader:      reader,
          source:      source,
          writer:      writer).process
    end

    # @param destination []
    # @param reader []
    # @param source []
    # @param writer []
    # @return [void]
    # @todo
    def initialize(destination:, reader:, source:, writer: nil)
      @destination = destination
      @reader      = reader
      @source      = source
      @writer      = writer
    end

    # @return [void]
    # @todo
    def process
      write
    end

    private

    # @return [void]
    # @todo
    def read
      fail Coloration::NoSourceError,
        'No source file was specified.' unless source

      Coloration.log("Source: #{source}")

      File.read(source)
    end

    # @return [void]
    # @todo
    def reader
      fail Coloration::NoReaderError, 'No reader was specified.' unless @reader

      Coloration.log("Reader: #{@reader.inspect}")

      @_reader ||= Coloration::Readers::TextMate.new(read, @reader)
    end

    # @return [void]
    # @todo
    def output
      fail Coloration::NoWriterError, 'No writer was specified.' unless writer

      Coloration.log("Writer: #{writer.inspect}")

      @_writer ||= writer.translate(input, @reader)
    end

    # @return [void]
    # @todo
    def input
      reader.parse
    end

    # @return [void]
    # @todo
    def write
      fail Coloration::NoDestinationError,
        'No destination file was specified.' unless destination

      Coloration.log("Destination: #{destination}")
      # Coloration.log("Output: #{output.inspect}")

      File.open(destination, 'w') { |f| f.write(output) }

      output
    end

    # @return [void]
    # @todo
    def writer
      @writer || reader.writer
    end

  end # Parser

end # Coloration
