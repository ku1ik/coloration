module Coloration
  module Writers
    module VimThemeWriter

      def add_line(line="")
        (@lines ||= []) << line
      end

      def format_item(name, style_or_item_name)
        raise RuntimeError.new("Style for #{name} is missing!") if style_or_item_name.nil?
        if style_or_item_name == :inverse
          "hi #{name} gui=inverse"
        else
          if style_or_item_name.is_a?(Style)
            style = style_or_item_name
          else
            style = @items[style_or_item_name]
          end
          "hi #{name} #{format_style(style)}"
        end
      end

      def format_style(style)
        style ||= Style.new
        s = ""
        s << " guifg=" << (style.foreground.try(:html) || "NONE")
        s << " guibg=" << (style.background.try(:html) || "NONE")
        gui = [style.inverse && "inverse", style.bold && "bold", style.underline && "underline", style.italic && "italic"].compact
        s << " gui=" << (gui.empty? ? "NONE" : gui.join(","))
        s
      end

      def build_result
        add_line "set background=dark"
        add_line "highlight clear"
        add_line
        add_line 'if exists("syntax_on")'
        add_line "  syntax reset"
        add_line "endif"
        add_line
        add_line "let g:colors_name = \"#{@name}\""
        add_line

        ui_mapping = {
          "Cursor" => Style.new(:bg => @ui["caret"]),
          "Visual" => Style.new(:bg => @ui["selection"]),
          "CursorLine" => Style.new(:bg => @ui["lineHighlight"]),
          "CursorColumn" => Style.new(:bg => @ui["lineHighlight"]),
          "LineNr" => Style.new(:fg => @items["comment"].foreground, :bg => @ui["selection"].mix_with(@ui["background"], 20)),
          "VertSplit" => Style.new(:fg => @ui["selection"], :bg => @ui["selection"]),
          "MatchParen" => @items["keyword"],
          "StatusLine" => Style.new(:fg => @ui["foreground"], :bg => @ui["selection"], :bold => true),
          "StatusLineNC" => Style.new(:fg => @ui["foreground"], :bg => @ui["selection"]),
          "Pmenu" => "entity.name",
          "PmenuSel" => Style.new(:bg => @ui["selection"]),
          "IncSearch" => Style.new(:bg => @items["variable"].foreground.mix_with(@ui["background"], 33)),
          "Search" => Style.new(:bg => @items["variable"].foreground.mix_with(@ui["background"], 33)),
          "Directory" => "constant.other.symbol",
        }

        ui_mapping.keys.each do |key|
          add_line(format_item(key, ui_mapping[key]))
        end

        add_line

        items_mapping = {
          # general colors for all languages
          "Normal" => Style.new(:fg => @ui["foreground"], :bg => @ui["background"]),
          "Boolean" => "constant.language",
          "Character" => "constant.character",
          "Comment" => "comment",
          "Conditional" => "keyword.control",
          "Constant" => "constant",
          #"Debug" => [],
          "Define" => "keyword",
          #"Delimiter" => "meta.separator",
          "ErrorMsg" => "invalid",
          "WarningMsg" => "invalid",
          #"Exception" => [],
          "Float" => "constant.numeric",
          "Function" => "entity.name.function",
          "Identifier" => "storage.type",
          #"Include" => [],
          "Keyword" => "keyword",
          "Label" => "string.other",
          #"Macro" => [],
          "NonText" => Style.new(:fg => @ui["invisibles"], :bg => @ui["lineHighlight"]),
          "Number" => "constant.numeric",
          "Operator" => "keyword.operator",
          #"PreCondit" => [],
          "PreProc" => "keyword.other",
          #"Repeat" => [],
          "Special" => Style.new(:fg => @ui["foreground"]),
          #"SpecialChar" => [],
          #"SpecialComment" => [],
          "SpecialKey" => Style.new(:fg => @ui["invisibles"], :bg => @ui["lineHighlight"]),
          "Statement" => "keyword.control",
          "StorageClass" => "storage.type",
          "String" => "string",
          #"Structure" => [],
          "Tag" => "entity.name.tag",
          "Title" => Style.new(:fg => @ui["foreground"], :bold => true),
          "Todo" => @items["comment"].clone.tap { |c| c.inverse = true; c.bold = true },
          "Type" => "entity.name.type",
          #"Typedef" => [],
          "Underlined" => Style.new(:underline => true),

          # ruby
          "rubyClass" => "keyword.controll.class.ruby",
          "rubyFunction" => "entity.name.function.ruby",
          "rubyInterpolationDelimiter" => "",
          "rubySymbol" => "constant.other.symbol.ruby",
          "rubyConstant" => "support",
          "rubyStringDelimiter" => "string",
          "rubyBlockParameter" => "variable.parameter",
          "rubyInstanceVariable" => "variable.language",
          "rubyInclude" => "keyword.other.special-method.ruby",
          "rubyGlobalVariable" => "variable.other",
          "rubyRegexp" => "string.regexp",
          "rubyRegexpDelimiter" => "string.regexp",
          "rubyEscape" => "constant.character.escape",
          "rubyControl" => "keyword.control",
          "rubyClassVariable" => "variable",
          "rubyOperator" => "keyword.operator",
          "rubyException" => "keyword.other.special-method.ruby",
          "rubyPseudoVariable" => "variable.language.ruby",

          # rails
          "rubyRailsUserClass" => "support.class.ruby",
          "rubyRailsARAssociationMethod" => "support.function.activerecord.rails",
          "rubyRailsARMethod" => "support.function.activerecord.rails",
          "rubyRailsRenderMethod" => "support.function",
          "rubyRailsMethod" => "support.function",

          # eruby
          "erubyDelimiter" => "punctuation.section.embedded.ruby",
          "erubyComment" => "comment",
          "erubyRailsMethod" => "support.function",
          #"erubyExpression" => "text.html.ruby source",
          #"erubyDelimiter" => "",

          # html
          "htmlTag" => "meta.tag entity",
          "htmlEndTag" => "meta.tag entity",
          "htmlTagName" => "meta.tag entity",
          "htmlArg" => "meta.tag entity",
          "htmlSpecialChar" => "constant.character.entity.html",

          # javascript
          "javaScriptFunction" => "storage.type.function.js",
          "javaScriptRailsFunction" => "support.function",
          "javaScriptBraces" => "meta.brace.curly.js",

          # yaml
          "yamlKey" => "entity.name.tag.yaml",
          "yamlAnchor" => "variable.other.yaml",
          "yamlAlias" => "variable.other.yaml",
          "yamlDocumentHeader" => "string.unquoted.yaml",

          # css
          "cssURL" => "variable.parameter.misc.css",
          "cssFunctionName" => "support.function.misc.css",
          "cssColor" => "constant.other.color.rgb-value.css",
          "cssPseudoClassId" => "entity.other.attribute-name.pseudo-class.css",
          "cssClassName" => "entity.other.attribute-name.class.css",
          "cssValueLength" => "constant.numeric.css",
          "cssCommonAttr" => "support.constant.property-value.css",
          "cssBraces" => "punctuation.section.property-list.css",
        }

        items_mapping.keys.each do |key|
          add_line(format_item(key, items_mapping[key]))
        end

        self.result = @lines.join("\n")
      end
    end
  end
end
