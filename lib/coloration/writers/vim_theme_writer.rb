module Coloration

  module Writers

    module VimThemeWriter

      include Coloration::Writers::AbstractWriter

      XTERM_COLORS = [ 0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF ]
      XTERM_GREYS  = [ 0x08, 0x12, 0x1C, 0x26, 0x30, 0x3A,
                       0x44, 0x4E, 0x58, 0x62, 0x6C, 0x76,
                       0x80, 0x8A, 0x94, 0x9E, 0xA8, 0xB2,
                       0xBC, 0xC6, 0xD0, 0xDA, 0xE4, 0xEE ]

      def build_result
        add_line "\" Vim color file"
        add_line "\" #{comment_message}"
        add_line

        add_line "set background=dark"
        add_line "highlight clear"
        add_line
        add_line 'if exists("syntax_on")'
        add_line "  syntax reset"
        add_line "endif"
        add_line
        add_line "let g:colors_name = \"#{@name}\""
        add_line

        default_style = Style.new(:fg => @ui["foreground"])
        border_color = @ui["background"].mix_with(@ui["foreground"], 71)
        bg_line_color = @ui["background"].mix_with(@ui["foreground"], 90)

        ui_mapping = {
          "Cursor" => Style.new(:fg => @ui['background'], :bg => @ui["caret"]),
          "Visual" => Style.new(:bg => @ui["selection"]),
          "CursorLine" => Style.new(:bg => bg_line_color),
          "CursorColumn" => Style.new(:bg => bg_line_color),
          "ColorColumn" => Style.new(:bg => bg_line_color),
          "LineNr" => Style.new(:fg => @ui["foreground"].mix_with(@ui["background"], 50), :bg => bg_line_color),
          "VertSplit" => Style.new(:fg => border_color, :bg => border_color),
          "MatchParen" => Style.new(:fg => @items["keyword"].foreground, :underline => true),
          "StatusLine" => Style.new(:fg => @ui["foreground"], :bg => border_color, :bold => true),
          "StatusLineNC" => Style.new(:fg => @ui["foreground"], :bg => border_color),
          "Pmenu" => "entity.name",
          "PmenuSel" => Style.new(:bg => @ui["selection"]),
          "IncSearch" => Style.new(:bg => @items['string'].foreground, :fg => @ui['background']),
          "Search" => Style.new(:underline => true),
          "Directory" => "constant.other.symbol",
          "Folded" => Style.new(:fg => @items["comment"].try(:foreground), :bg => @ui["background"]),
        }

        ui_mapping.keys.each do |key|
          add_line(format_item(key, ui_mapping[key] || default_style))
        end

        add_line

        bg_brightness = @ui["background"].brightness
        if bg_brightness >= 0.5
          # from Tango palette, lighter
          red   = Color::RGB.from_html '#ef2929'
          green = Color::RGB.from_html '#8ae234'
          blue  = Color::RGB.from_html '#729fcf'
        else
          # from Tango palette, darker
          red   = Color::RGB.from_html '#a40000'
          green = Color::RGB.from_html '#4e9a06'
          blue  = Color::RGB.from_html '#204a87'
        end

        items_mapping = {
          # general colors for all languages
          "Normal"      => Style.new(:fg => @ui["foreground"], :bg => @ui["background"]),
          "Boolean"     => "constant.language",
          "Character"   => "constant.character",
          "Comment"     => "comment",
          "Conditional" => "keyword.control",
          "Constant"    => "constant",
          # "Debug" => [],
          "Define"      => "keyword",
          # "Delimiter" => "meta.separator",
          "DiffAdd"     => Style.new(:bg => green.mix_with(@ui['background'], 80), :fg => @ui['foreground'], :bold => true),
          "DiffDelete"  => Style.new(:fg => red.mix_with(@ui['background'], 80)),
          "DiffChange"  => Style.new(:bg => blue.mix_with(@ui['background'], 50), :fg => @ui['foreground']),
          "DiffText"    => Style.new(:bg => blue.mix_with(@ui['background'], 100), :fg => @ui['foreground'], :bold => true),
          "ErrorMsg"    => "invalid",
          "WarningMsg"  => "invalid",
          # "Exception" => [],
          "Float"       => "constant.numeric",
          "Function"    => "entity.name.function",
          "Identifier"  => "storage.type",
          # "Include" => [],
          "Keyword"     => "keyword",
          "Label"       => "string.other",
          # "Macro" => [],
          "NonText"     => Style.new(:fg => @ui["invisibles"], :bg => @ui["background"].mix_with(@ui["foreground"], 95)),
          "Number"      => "constant.numeric",
          "Operator"    => "keyword.operator",
          # "PreCondit" => [],
          "PreProc"     => "keyword.other",
          # "Repeat" => [],
          "Special"     => Style.new(:fg => @ui["foreground"]),
          # "SpecialChar" => [],
          # "SpecialComment" => [],
          "SpecialKey"   => Style.new(:fg => @ui["invisibles"], :bg => bg_line_color),
          "Statement"    => "keyword.control",
          "StorageClass" => "storage.type",
          "String"       => "string,string.quoted",
          # "Structure" => [],
          "Tag"          => "entity.name.tag",
          "Title"        => Style.new(:fg => @ui["foreground"], :bold => true),
          "Todo"         => (@items["comment"] || default_style).clone.tap { |c| c.inverse = true; c.bold = true },
          "Type"         => "entity.name.type",
          # "Typedef" => [],
          "Underlined"   => Style.new(:underline => true),

          # ruby
          "rubyClass"                  => "keyword.controll.class.ruby",
          "rubyFunction"               => "entity.name.function.ruby",
          "rubyInterpolationDelimiter" => "",
          "rubySymbol"                 => "constant.other.symbol.ruby",
          "rubyConstant"               => "support.class",
          "rubyStringDelimiter"        => "string,string.quoted",
          "rubyBlockParameter"         => "variable.parameter",
          "rubyInstanceVariable"       => "variable.language",
          "rubyInclude"                => "keyword.other.special-method.ruby",
          "rubyGlobalVariable"         => "variable.other",
          "rubyRegexp"                 => "string.regexp",
          "rubyRegexpDelimiter"        => "string.regexp",
          "rubyEscape"                 => "constant.character.escape",
          "rubyControl"                => "keyword.control",
          "rubyClassVariable"          => "variable",
          "rubyOperator"               => "keyword.operator",
          "rubyException"              => "keyword.other.special-method.ruby",
          "rubyPseudoVariable"         => "variable.language.ruby",

          # rails
          "rubyRailsUserClass"           => "support.class.ruby",
          "rubyRailsARAssociationMethod" => "support.function.activerecord.rails",
          "rubyRailsARMethod"            => "support.function.activerecord.rails",
          "rubyRailsRenderMethod"        => "support.function",
          "rubyRailsMethod"              => "support.function",

          # eruby
          "erubyDelimiter"   => "punctuation.section.embedded.ruby",
          "erubyComment"     => "comment",
          "erubyRailsMethod" => "support.function",
          # "erubyExpression" => "text.html.ruby source",
          # "erubyDelimiter" => "",

          # html
          "htmlTag"         => "meta.tag entity",
          "htmlEndTag"      => "meta.tag entity",
          "htmlTagName"     => "meta.tag entity",
          "htmlArg"         => "meta.tag entity",
          "htmlSpecialChar" => "constant.character.entity.html",

          # javascript
          "javaScriptFunction"      => "storage.type.function.js",
          "javaScriptRailsFunction" => "support.function",
          "javaScriptBraces"        => "meta.brace.curly.js",

          # yaml
          "yamlKey"            => "entity.name.tag.yaml",
          "yamlAnchor"         => "variable.other.yaml",
          "yamlAlias"          => "variable.other.yaml",
          "yamlDocumentHeader" => "string.unquoted.yaml",

          # css
          "cssURL"           => "variable.parameter.misc.css",
          "cssFunctionName"  => "support.function.misc.css",
          "cssColor"         => "constant.other.color.rgb-value.css",
          "cssPseudoClassId" => "entity.other.attribute-name.pseudo-class.css",
          "cssClassName"     => "entity.other.attribute-name.class.css",
          "cssValueLength"   => "constant.numeric.css",
          "cssCommonAttr"    => "support.constant.property-value.css",
          "cssBraces"        => "punctuation.section.property-list.css",
        }

        items_mapping.keys.each do |key|
          add_line(format_item(key, items_mapping[key] || default_style))
        end

        self.result = @lines.join("\n")
      end

      protected

      def format_item(name, style_or_item_name)
        raise RuntimeError, "Style for #{name} is missing!" if style_or_item_name.nil?

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

        if fg = style.foreground
          ctermfg = rgb_to_xterm256(fg)
          guifg = fg.html
        else
          ctermfg = 'NONE'
          guifg = 'NONE'
        end

        if bg = style.background
          ctermbg = rgb_to_xterm256(bg)
          guibg = bg.html
        else
          ctermbg = 'NONE'
          guibg = 'NONE'
        end

        gui_attrs = [
          style.inverse && 'inverse',
          style.bold && 'bold',
          style.underline && 'underline',
          style.italic && 'italic'
        ].compact

        cterm_attrs = gui_attrs.reject { |a| a == 'italic' }

        gui = gui_attrs.empty? ? 'NONE' : gui_attrs.join(',')
        cterm = cterm_attrs.empty? ? 'NONE' : cterm_attrs.join(',')

        "ctermfg=#{ctermfg} ctermbg=#{ctermbg} cterm=#{cterm} " +
          "guifg=#{guifg} guibg=#{guibg} gui=#{gui}"
      end

      def rgb_to_xterm256(c)
        a_r = (c.r * 255.0).to_i
        a_g = (c.g * 255.0).to_i
        a_b = (c.b * 255.0).to_i

        if a_r == 0 && a_g == 0 && a_b == 0
          return 0
        end

        if a_r == 255 && a_g == 255 && a_b == 255
          return 15
        end

        greys_colors = XTERM_GREYS + XTERM_COLORS
        len = XTERM_COLORS.size

        r = get_nearest_xterm_color(a_r, greys_colors)
        g = get_nearest_xterm_color(a_g, greys_colors)
        b = get_nearest_xterm_color(a_b, greys_colors)

        if r == g && g == b && (i = XTERM_GREYS.index(r))
          n = len * len * len + i
        else
          r = get_nearest_xterm_color(a_r, XTERM_COLORS)
          g = get_nearest_xterm_color(a_g, XTERM_COLORS)
          b = get_nearest_xterm_color(a_b, XTERM_COLORS)

          n = XTERM_COLORS.index(r) * len * len +
              XTERM_COLORS.index(g) * len +
              XTERM_COLORS.index(b)
        end

        16 + n
      end

      def get_nearest_xterm_color(v, colors)
        0.upto(colors.size - 2) do |i|
          return colors[i] if v <= (colors[i] + colors[i+1]) / 2
        end

        colors.last
      end

    end # VimThemeWriter

  end # Writers

end # Coloration
