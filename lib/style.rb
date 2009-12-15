module Coloration

  class Style
    attr_accessor :foreground, :background, :bold, :italic, :underline, :strike
    
    def initialize(obj=nil)
      if obj
        case obj
        when String
          initialize_from_hash({ :foreground => obj })
        when Hash
          initialize_from_hash(obj)
        end
      end
    end
    
    def initialize_from_hash(h)
      h.keys.each do |key|
        value = h[key]
        if value.is_a?(String)
          value = Color::RGB.from_html(value[0..6])
        end
        send("#{key}=", value)
      end
    end
    
    def blank?
      foreground.nil? && background.nil?
    end
  end
  
end

