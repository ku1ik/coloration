module Coloration

  class Style

    attr_accessor :foreground, :background, :bold, :italic, :underline, :strike,
      :inverse, :comment

    # @param obj []
    # @param bg []
    # @return [Coloration::Style]
    # @todo
    def initialize(obj = nil, bg = nil)
      if obj
        case obj
        when String
          initialize_from_hash({ foreground: obj }, bg)
        when Hash
          initialize_from_hash(obj, bg)
        end
      end
    end

    # @param h []
    # @param bg []
    # @return [void]
    # @todo
    def initialize_from_hash(h, bg = nil)
      h.each do |key, v|
        key = :foreground if key == :fg
        key = :background if key == :bg

        if ['foreground', 'background'].include?(key.to_s) && v.is_a?(String)

          v = Color::RGBA.from_html(v, bg)
        end
        send("#{key}=", v)
      end
    end

    # @return [Boolean]
    def blank?
      foreground.nil? && background.nil?
    end

  end # Style

end # Coloration
