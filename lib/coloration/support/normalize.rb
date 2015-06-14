module Coloration

  class Normalize

    # @return [Float]
    def self.[](value)
      new(value).[]
    end

    # @param value [Float]
    # @return [Coloration::Normalize]
    def initialize(value)
      @value = value
    end

    # @return [Float]
    def []
      @value = 1.0 if @value > 1
      @value = 0.0 if @value < 0

      @value
    end

  end # Normalize

end # Coloration
