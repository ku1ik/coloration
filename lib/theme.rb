module Coloration
  class Theme
    attr_accessor :name, :ui, :items
    
    def initialize(theme=nil)
      if theme
        @original_theme = theme
        @name = theme.name
        @ui = theme.ui
        @items = theme.items
      end
    end
    
#     def method_missing(name, *args)
#       if name.to_s.end_with?("=") && args.size == 1
#         @properties[name.to_s[0..-2].to_sym] = args.first
#       elsif args.size == 0
#         @properties[name.to_sym]
#       else
#         super
#       end
#     end
    
    def format_name(name)
      name.to_s
    end
    
    def format_string(s)
      s
    end
    
    def format_value(value)
      if value.is_a?(Hash)
        format_style(value)
      else
        format_string(value)
      end
    end
    
    def format_token(name, value)
      if v = format_value(value)
        "#{format_name(name)}=#{v}"
      end
    end
    
    def format_style(style)
      raise RuntimeError.new("You must implement format_style method!")
    end
    
    def format_comment(text); end
    
    def build
      raise RuntimeError.new("You must implement build method!")
    end
    
    def add_line(line)
      @lines << line
    end

    def add_comment(text)
      if comment = format_comment(text)
        add_line(comment)
      end
    end
    
    def to_s
      @lines = []
      add_comment "#{self.name} theme for #{self.class.editor_name}"
      add_comment "Generated from #{@original_theme.class.editor_name} theme with Coloration (http://github.com/sickill/coloration)\n"
      build
      @lines.compact.join("\n")
#       @properties.inspect
    end
  end
end
