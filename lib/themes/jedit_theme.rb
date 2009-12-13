module Coloration
  class JEditTheme < Theme
    def self.editor_name
      "JEdit"
    end
    
    def self.parse(text)
      raise RuntimeError.new("Not implemented yet")
    end
    
    def format_value(value)
      v = super(value)
      v && v.gsub(/:/, '\:').gsub(/#/, '\#').strip
    end
    
    def format_style(style)
      return if style.nil?
      s = ""
      s << " color:#{prepare_color(style[:foreground])}" if style[:foreground] 
      s << " bgColor:#{prepare_color(style[:background])}" if style[:background]
      if s.size > 0
        s << " style:"
        s << "b" if style[:bold]
        s << "u" if style[:underline]
        s << "i" if style[:italic]
      end
      s.size > 0 ? s : nil
    end
    
    def format_comment(text)
      "\# #{text}"
    end
    
    def build
      #add_property "console.font", "Monospaced"
      tokens = {
        "scheme.name"             => @name,
        "view.fgColor"            => @ui[:foreground],
        "view.bgColor"            => @ui[:background],
        "view.caretColor"         => @ui[:caret],
        "view.selectionColor"     => @ui[:selection],
        "view.eolMarkerColor"     => @ui[:invisibles],
        "view.lineHighlightColor" => @ui[:line_highlight],
        
        "view.style.comment1"     => @items[:comment], # #foo
        "view.style.literal1"     => @items[:string], # "foo"
        "view.style.label"        => @items["constant.other.symbol"], # :foo
        "view.style.digit"        => @items["constant.numeric"], # 123
        "view.style.keyword1"     => @items["keyword.control"], # class, def, if, end
        "view.style.keyword2"     => @items["support.function"], # require, include
        "view.style.keyword3"     => @items["constant.language"], # true, false, nil
        "view.style.keyword4"     => @items["variable"] || @items["variable.other"], # @foo
        "view.style.operator"     => @items["keyword.operator"], # = < + -
        "view.style.function"     => @items["entity.name.function"], # def foo
        "view.style.literal3"     => @items["string.regexp"], # /jola/
        #"view.style.literal4" => :constant # MyClass, USER_SPACE
        "view.style.markup"       => @items["meta.tags"] # <div>
      }
      #TODO: gutter etc
      tokens.keys.each do |key|
        add_line(format_token(key, tokens[key]))
      end
    end
    
    protected
    
    def prepare_color(col)
      col.downcase
    end
  end
end
