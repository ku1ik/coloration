module Coloration
  class KatePartTheme < Theme
    def self.editor_name
      "Kate"
    end
    
    def self.parse(text)
      raise RuntimeError.new("Not implemented yet")
    end
    
    def format_style(style)
      style ||= @default_style
      # normal,selected,bold,italic,strike,underline,bg,bg_selected,---
      s = []
      s << style.foreground.html.gsub('#', '')
      s << nil
      s << style.bold.to_i
      s << style.italic.to_i
      s << style.strike.to_i
      s << style.underline.to_i
      s << (style.background ? style.background.html.gsub('#', '') : nil)
      s << nil
      s << "---"
      s.join(",")
    end
    
    def format_item(name, style)
      raise RuntimeError.new("Style for #{name} is missing!") if style.nil?
      "#{name}=#{format_style(style)}"
    end
    
    def format_comment(text)
      "# #{text}"
    end
    
    def build
      add_comment "Put following into katesyntaxhighlightingrc\n"
      
      add_line "[Default Item Styles - Schema #{name}]"
      
      @default_style = Style.new
      @default_style.foreground = @ui[:foreground]
      
      items = {
        "Alert"          => @items["invalid"], #
        "Base-N Integer" => @items["constant.numeric"],
        "Character"      => @items["keyword.operator"],
        "Comment"        => @items[:comment],
        "Data Type"      => @items["entity.name.type"],
        "Decimal/Value"  => @items["constant.numeric"],
        "Error"          => @items["invalid"], #
        "Floating Point" => @items["constant.numeric"],
        "Function"       => @items["entity.name.function"],
        "Keyword"        => @items["keyword"],
        "Normal"         => @default_style,
        "Others"         => nil, #
        "Region Marker"  => nil, #
        "String"         => @items["string"]
      }

      items.keys.each do |key|
        add_line(format_item(key, items[key] || @default_style))
      end
      
      add_line ""
      
      add_line "[Highlighting Ruby - Schema #{name}]"
      add_line("Ruby:Access Control=0," + format_style(@items["keyword"]))
      add_line("Ruby:Command=0," + format_style(@items["string.interpolated"]))
      add_line("Ruby:Constant Value=0," + format_style(@items["constant.other"]))
      add_line("Ruby:Default globals=0," + format_style(@items["variable.other"]))
      add_line("Ruby:Definition=0," + format_style(@items["entity.name.function"]))
      add_line("Ruby:Delimiter=0," + format_style(@items["keyword.other"]))
      add_line("Ruby:Global Constant=0," + format_style(@items["constant.other"]))
      add_line("Ruby:Global Variable=0," + format_style(@items["variable.other"]))
      add_line("Ruby:Kernel methods=0," + format_style(@items["support.function"]))
      add_line("Ruby:Message=0," + format_style(@default_style))
      add_line("Ruby:Operator=0," + format_style(@items["keyword.operator"]))
      add_line("Ruby:Pseudo variable=0," + format_style(@items["constant.language"]))
      add_line("Ruby:Raw String=0," + format_style(@items["string.quoted.single"]))
#       add_line("Ruby:Region Marker=7," + format_style(@items[""]))
      add_line("Ruby:Regular Expression=0," + format_style(@items["string.regexp.ruby"]))
      add_line("Ruby:Symbol=0," + format_style(@items["constant.other.symbol.ruby"]))
      
      
      add_comment "-------------------------------------\n"
      add_comment "Put following into kateschemarc\n"

      add_line "[#{name}]"

      ui = {
        "Color Background"            => @ui[:background],
#         "Color Highlighted Bracket" => :,
        "Color Highlighted Line"      => @ui[:line_highlight],
#         "Color Icon Bar" => :,
#         "Color Line Number" => :,
#         "Color MarkType1" => :,
#         "Color MarkType2" => :,
#         "Color MarkType3" => :,
#         "Color MarkType4" => :,
#         "Color MarkType5" => :,
#         "Color MarkType6" => :,
#         "Color MarkType7" => :,
        "Color Selection"             => @ui[:selection],
#         "Color Tab Marker" => :,
#         "Color Template Background" => :,
#         "Color Template Editable Placeholder" => :,
#         "Color Template Focused Editable Placeholder" => :,
#         "Color Template Not Editable Placeholder" => :,
#         "Color Word Wrap Marker" => :
      }
#       Font=Monospace,9,-1,5,50,0,0,0,0,0
      ui.keys.each do |key|
#         add_line(format_token(key, self.send(tokens[key])))
        add_line("#{key}=#{hex2rgb(ui[key])}")
      end
      
    end
    
    def hex2rgb(col)
      "#{(col.r*255).to_i},#{(col.g*255).to_i},#{(col.b*255).to_i}"
    end
    
  end
end
