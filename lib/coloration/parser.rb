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

    # @param converter []
    # @param destination []
    # @param source []
    # @param writer []
    # @return [void]
    # @todo
    def self.process(converter:, destination:, source:, writer: nil)
      new(converter:   converter,
          destination: destination,
          source:      source,
          writer:      writer).process
    end

    # @param converter []
    # @param destination []
    # @param source []
    # @param writer []
    # @return [void]
    # @todo
    def initialize(converter:, destination:, source:, writer: nil)
      @converter   = converter
      @destination = destination
      @source      = source
      @writer      = writer
    end

    # @return [void]
    # @todo
    def process
      write
    end

    protected

    # @!attribute [r] converter
    # @return [void]
    # @todo
    attr_reader :converter

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
      fail Coloration::NoConverterError,
        'No converter was specified.' unless converter

      Coloration.log("Converter: #{converter.inspect}")

      @reader ||= Coloration::Readers::TextMate.new(read, converter)
    end

    # @return [void]
    # @todo
    def output
      fail Coloration::NoWriterError, 'No writer was specified.' unless writer

      Coloration.log("Writer: #{writer.inspect}")

      @_writer ||= writer.translate(input, converter, reader)
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
      @writer || converter.writer
    end

  end # Parser

end # Coloration
