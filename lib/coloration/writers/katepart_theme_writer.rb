module Coloration
  module Writers
    module KatePartThemeWriter

      def add_comment(c)
        add_line("# #{c}")
      end

      def add_line(line)
        @lines << line
      end

      def add_file(file_name)
        @lines = []
        (@files ||= {})[file_name] = @lines
      end

      def format_style(style)
        style ||= @default_style
        # normal,selected,bold,italic,strike,underline,bg,bg_selected,---
        s = []
        s << style.foreground.html.gsub('#', '')
        s << style.foreground.html.gsub('#', '')
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

      def get_files
        add_file "katesyntaxhighlightingrc"

        add_line "[Default Item Styles - Schema #{name}]"

        @default_style = Style.new
        @default_style.foreground = @ui[:foreground]

        items_mapping = {
          "Alert"          => @items["invalid"],
          "Base-N Integer" => @items["constant.numeric"],
          "Character"      => @items["keyword.operator"],
          "Comment"        => @items["comment"],
          "Data Type"      => @items["entity.name.type", false] || @items["entity.name.class"],
          "Decimal/Value"  => @items["constant.numeric"],
          "Error"          => @items["invalid"],
          "Floating Point" => @items["constant.numeric"],
          "Function"       => @items["entity.name.function"],
          "Keyword"        => @items["keyword"],
          "Normal"         => @default_style,
          "Others"         => nil,
          "Region Marker"  => nil,
          "String"         => @items["string"]
        }

        items_mapping.keys.each do |key|
          add_line(format_item(key, items_mapping[key] || @default_style))
        end

        add_line ""

        add_line "[Highlighting Ruby - Schema #{name}]"
        add_line "Ruby:Access Control=0," + format_style(@items["storage.modifier"])
        add_line "Ruby:Command=0," + format_style(@items["string.interpolated"])
        add_line "Ruby:Constant=0," + format_style(@items["constant"])
        add_line "Ruby:Constant Value=0," + format_style(@items["constant.other"])
        add_line "Ruby:Default globals=0," + format_style(@items["variable.other"])
        add_line "Ruby:Definition=0," + format_style(@items["entity.name.function"])
        add_line "Ruby:Delimiter=0," + format_style(@items["keyword.other"])
        add_line "Ruby:Global Constant=0," + format_style(@items["constant.other"])
        add_line "Ruby:Global Variable=0," + format_style(@items["variable.other"])
        add_line "Ruby:Instance Variable=0," + format_style(@items["variable"])
        add_line "Ruby:Class Variable=0," + format_style(@items["variable"])
        add_line "Ruby:Kernel methods=0," + format_style(@items["support.function"])
        add_line "Ruby:Member=0," + format_style(@items["entity.name.function"])
        add_line "Ruby:Message=0," + format_style(@default_style)
        add_line "Ruby:Operator=0," + format_style(@items["keyword.operator"])
        add_line "Ruby:Pseudo variable=0," + format_style(@items["variable.language"])
        add_line "Ruby:Raw String=0," + format_style(@items["string.quoted.single"])
  #       add_line "Ruby:Region Marker=7," + format_style(@items[""])
        add_line "Ruby:Regular Expression=0," + format_style(@items["string.regexp.ruby"])
        add_line "Ruby:Symbol=0," + format_style(@items["constant.other.symbol.ruby"])

        add_line ""

        add_line "[Highlighting JavaScript - Schema #{name}]"
        add_line "JavaScript:Objects=0," + format_style(@items["variable.language"])

        add_line ""

        add_line "[Highlighting Ruby/Rails/RHTML - Schema #{name}]"
        add_line "Ruby/Rails/RHTML:Message=0," + format_style(@default_style)
        add_line "Ruby/Rails/RHTML:Raw String=0," + format_style(@items["string.quoted.single"])
        add_line "Ruby/Rails/RHTML:Symbol=0," + format_style(@items["constant.other.symbol.ruby"])
        add_line "Ruby/Rails/RHTML:Value=0," + format_style(@items["string"])
        add_line "Ruby/Rails/RHTML:Element=0," + format_style(@items["meta.tag"] || @items["entity.name.tag"])
        add_line "Ruby/Rails/RHTML:Kernel methods=0," + format_style(@items["support.function"])
        add_line "Ruby/Rails/RHTML:Attribute=0," + format_style(@items["entity.other.attribute-name"])

        add_line ""

        add_line "[Highlighting XML - Schema #{name}]"
        add_line "XML:Value=0," + format_style(@items["string"])
        add_line "XML:Element=0," + format_style(@items["meta.tag"] || @items["entity.name.tag"])
        add_line "XML:Attribute=0," + format_style(@items["entity.other.attribute-name"])

        add_file "kateschemarc"

        add_line "[#{name}]"

        ui_mapping = {
          "Color Background"            => @ui[:background],
          "Color Highlighted Bracket"   => @ui[:background],
          "Color Highlighted Line"      => @ui[:line_highlight],
  #         "Color Icon Bar"              => @ui[:background],
  #         "Color Line Number" => :,
  #         "Color MarkType1" => :,
  #         "Color MarkType2" => :,
  #         "Color MarkType3" => :,
  #         "Color MarkType4" => :,
  #         "Color MarkType5" => :,
  #         "Color MarkType6" => :,
  #         "Color MarkType7" => :,
          "Color Selection"             => @ui[:selection],
          "Color Tab Marker"            => @ui[:invisibles],
  #         "Color Template Background" => :,
  #         "Color Template Editable Placeholder" => :,
  #         "Color Template Focused Editable Placeholder" => :,
  #         "Color Template Not Editable Placeholder" => :,
          "Color Word Wrap Marker"      => @ui[:invisibles]
        }
  #       Font=Monospace,9,-1,5,50,0,0,0,0,0
        ui_mapping.keys.each do |key|
  #         add_line(format_token(key, self.send(tokens[key])))
          add_line "#{key}=#{hex2rgb(ui_mapping[key])}"
        end

        @files.each { |k, v| @files[k] = v.join("\n") + "\n" }
      end

      def hex2rgb(col)
        "#{(col.r*255).to_i},#{(col.g*255).to_i},#{(col.b*255).to_i}"
      end

    end
  end
end
