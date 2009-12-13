module Coloration

  class Style
    attr_accessor :foreground, :background, :bold, :italic, :underline, :strike
    
    def initialize(obj)
      case obj
      when String
        initialize_from_hash({ :foreground => obj })
      when Hash
        initialize_from_hash(obj)
      end
    end
    
    def initialize_from_hash(h)
      h.keys.each do |key|
        value = h[key]
        if value.is_a?(String)
          value = Color::RGB.from_html(value)
        end
        send("#{key}=", value)
      end
    end
    
#     def to_s
#       "#<#{}>"
#     end
  end
  
end

