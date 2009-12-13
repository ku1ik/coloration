module Coloration
  class KatePartTheme < Theme
    def self.editor_name
      "Kate"
    end
    
    def self.parse(text)
      raise RuntimeError.new("Not implemented yet")
    end
    
    def format_style(style)
      # normal,selected,bold,italic,underline,strike,bg,bg_selected,---
      s = []
      s << style[:foreground].to_s.downcase.gsub('#', '')
      s << nil
      s << (style[:bold] ? "1" : nil)
      s << (style[:italic] ? "1" : nil)
      s << (style[:underline] ? "1" : nil)
      s << (style[:strike] ? "1" : nil)
      s << style[:background].to_s.downcase.gsub('#', '')
      s << nil
      s << "---"
      s.join(",")
    end
    
    def format_comment(text)
      nil
    end
    
    def format_comment(text)
      "\# #{text}"
    end
    
    def build
      p @properties
      add_comment "Put following into katesyntaxhighlightingrc"
      add_line "[Default Item Styles - Schema #{name}]"
      tokens = {
        "Alert"          => :none, #
        "Base-N Integer" => :number,
        "Character"      => :operator,
        "Comment"        => :comment,
        "Data Type"      => :constant,
        "Decimal/Value"  => :number,
        "Error"          => :none, #
        "Floating Point" => :number,
        "Function"       => :function,
        "Keyword"        => :keyword,
        "Normal"         => :normal,
        "Others"         => :none, #
        "Region Marker"  => :none, #
        "String"         => :string
      }
      tokens.keys.each do |key|
        add_line(format_token(key, self.send(tokens[key])))
      end
      
      add_comment "-------------------------------------"
      
      add_comment "Put following into kateschemarc"
      add_line "[#{name}]"

      tokens = {
        "Color Background" => :background,
#         "Color Highlighted Bracket" => :,
        "Color Highlighted Line" => :line_highlight,
#         "Color Icon Bar" => :,
#         "Color Line Number" => :,
#         "Color MarkType1" => :,
#         "Color MarkType2" => :,
#         "Color MarkType3" => :,
#         "Color MarkType4" => :,
#         "Color MarkType5" => :,
#         "Color MarkType6" => :,
#         "Color MarkType7" => :,
        "Color Selection" => :selection,
#         "Color Tab Marker" => :,
#         "Color Template Background" => :,
#         "Color Template Editable Placeholder" => :,
#         "Color Template Focused Editable Placeholder" => :,
#         "Color Template Not Editable Placeholder" => :,
#         "Color Word Wrap Marker" => :
      }
#       Font=Monospace,9,-1,5,50,0,0,0,0,0
      tokens.keys.each do |key|
#         add_line(format_token(key, self.send(tokens[key])))
        add_line("#{key}=#{hex2rgb(self.send(tokens[key]))}")
      end
      
    end
    
    def hex2rgb(col)
      r = col[1..2].to_i(16)
      g = col[3..4].to_i(16)
      b = col[5..6].to_i(16)
      "#{r},#{g},#{b}"
    end
    
  end
end
