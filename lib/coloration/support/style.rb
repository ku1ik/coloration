module Coloration

  class Style

    attr_accessor :foreground
    alias_method  :fg, :foreground
    alias_method  :fg=, :foreground=

    attr_accessor :background
    alias_method  :bg, :background
    alias_method  :bg=, :background=

    attr_accessor :bold
    attr_accessor :italic
    attr_accessor :underline
    attr_accessor :strike
    attr_accessor :inverse
    attr_accessor :comment

    # @param obj []
    # @param bg []
    # @return [Coloration::Style]
    # @todo
    def initialize(obj = nil, bg = nil)
      if obj
        case obj
        when String
          initialize_from_hash({ fg: obj }, bg)
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
        if [:fg, :bg].include?(key) && v.is_a?(String)
          v = Color::RGBA.from_html(v, bg)
        end
        send("#{key}=", v)
      end
    end

    # @return [Boolean]
    def blank?
      foreground.nil? && background.nil?
    end

    private

    # @return [Hash<Symbol => NilClass>]
    def defaults
      {
        fg:        nil,
        bg:        nil,
        bold:      nil,
        italic:    nil,
        underline: nil,
        strike:    nil,
        inverse:   nil,
        comment:   nil,
      }
    end

  end # Style

end # Coloration
