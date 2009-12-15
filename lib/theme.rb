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
    end
  end
end
