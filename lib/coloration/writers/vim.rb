module Coloration

  module Writers

    class Vim

      extend Forwardable

      def_delegators :reader, :items, :name, :ui

      include Coloration::Writers::AbstractWriter

      XTERM_COLORS = [ 0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF ]
      XTERM_GREYS  = [ 0x08, 0x12, 0x1C, 0x26, 0x30, 0x3A,
                       0x44, 0x4E, 0x58, 0x62, 0x6C, 0x76,
                       0x80, 0x8A, 0x94, 0x9E, 0xA8, 0xB2,
                       0xBC, 0xC6, 0xD0, 0xDA, 0xE4, 0xEE ]

      # @!attribute [r] from
      # @return [String]
      attr_reader :from

      # @!attribute [r] reader
      # @return []
      attr_reader :reader

      # @param input [String]
      # @param converter []
      # @param from [String]
      # @param reader []
      # @return [Coloration::Writers::Vim]
      # @todo
      def initialize(input, converter, from, reader)
        @input     = input
        @converter = converter
        @from      = from
        @reader    = reader
      end

      # @return [String]
      def translate
        Coloration.log('Writers::Vim#translate')

        store "\" Vim color file"
        store "\" #{comment_message}"
        store

        store 'set background=dark'
        store 'highlight clear'
        store
        store 'if exists("syntax_on")'
        store '  syntax reset'
        store 'endif'
        store
        store "let g:colors_name = \"#{name}\""
        store

        default_style = Coloration::Style.new(:fg => ui['foreground'])
        border_color  = ui['background'].mix_with(ui['foreground'], 71)
        bg_line_color = ui['background'].mix_with(ui['foreground'], 90)

        ui_mapping = {
          # 'Folded'       => Coloration::Style.new(:fg => @items['comment'].try(:foreground), :bg => ui['background']),
          # 'IncSearch'    => Coloration::Style.new(:bg => @items['string'].foreground, :fg => ui['background']),
          # 'MatchParen'   => Coloration::Style.new(:fg => @items['keyword'].foreground, :underline => true),

          'ColorColumn'  => Coloration::Style.new(:bg => bg_line_color),
          'Cursor'       => Coloration::Style.new(:fg => ui['background'], :bg => ui['caret']),
          'CursorColumn' => Coloration::Style.new(:bg => bg_line_color),
          'CursorLine'   => Coloration::Style.new(:bg => bg_line_color),
          'Directory'    => 'constant.other.symbol',
          'LineNr'       => Coloration::Style.new(:fg => ui['foreground'].mix_with(ui['background'], 50), :bg => bg_line_color),
          'Pmenu'        => 'entity.name',
          'PmenuSel'     => Coloration::Style.new(:bg => ui['selection']),
          'Search'       => Coloration::Style.new(:underline => true),
          'StatusLine'   => Coloration::Style.new(:fg => ui['foreground'], :bg => border_color, :bold => true),
          'StatusLineNC' => Coloration::Style.new(:fg => ui['foreground'], :bg => border_color),
          'VertSplit'    => Coloration::Style.new(:fg => border_color, :bg => border_color),
          'Visual'       => Coloration::Style.new(:bg => ui['selection']),
        }

        ui_mapping.keys.each do |key|
          store(format_item(key, ui_mapping[key] || default_style))
        end

        store

        bg_brightness = ui['background'].brightness
        if bg_brightness >= 0.5
          # from Tango palette, lighter
          red   = Coloration::Color::RGB.from_html '#ef2929'
          green = Coloration::Color::RGB.from_html '#8ae234'
          blue  = Coloration::Color::RGB.from_html '#729fcf'
        else
          # from Tango palette, darker
          red   = Coloration::Color::RGB.from_html '#a40000'
          green = Coloration::Color::RGB.from_html '#4e9a06'
          blue  = Coloration::Color::RGB.from_html '#204a87'
        end

        items_mapping = {
          # not currently supported
          # 'Delimiter'      => 'meta.separator',
          # 'Debug'          => [],
          # 'Exception'      => [],
          # 'Include'        => [],
          # 'Macro'          => [],
          # 'PreCondit'      => [],
          # "Repeat"         => [],
          # 'SpecialChar'    => [],
          # 'SpecialComment' => [],
          # 'Structure'      => [],
          # 'Todo'           => (@items['comment'] || default_style).clone.tap { |c| c.inverse = true; c.bold = true },
          # 'Typedef'        => [],

          # general colors for all languages

          'Boolean'      => 'constant.language',
          'Character'    => 'constant.character',
          'Comment'      => 'comment',
          'Conditional'  => 'keyword.control',
          'Constant'     => 'constant',
          'Define'       => 'keyword',
          'DiffAdd'      => Coloration::Style.new(:bg => green.mix_with(ui['background'], 80), :fg => ui['foreground'], :bold => true),
          'DiffChange'   => Coloration::Style.new(:bg => blue.mix_with(ui['background'], 50), :fg => ui['foreground']),
          'DiffDelete'   => Coloration::Style.new(:fg => red.mix_with(ui['background'], 80)),
          'DiffText'     => Coloration::Style.new(:bg => blue.mix_with(ui['background'], 100), :fg => ui['foreground'], :bold => true),
          'ErrorMsg'     => 'invalid',
          'Float'        => 'constant.numeric',
          'Function'     => 'entity.name.function',
          'Identifier'   => 'storage.type',
          'Keyword'      => 'keyword',
          'Label'        => 'string.other',
          'NonText'      => Coloration::Style.new(:fg => ui['invisibles'], :bg => ui['background'].mix_with(ui['foreground'], 95)),
          'Normal'       => Coloration::Style.new(:fg => ui['foreground'], :bg => ui['background']),
          'Number'       => 'constant.numeric',
          'Operator'     => 'keyword.operator',
          'PreProc'      => 'keyword.other',
          'Special'      => Coloration::Style.new(:fg => ui['foreground']),
          'SpecialKey'   => Coloration::Style.new(:fg => ui['invisibles'], :bg => bg_line_color),
          'Statement'    => 'keyword.control',
          'StorageClass' => 'storage.type',
          'String'       => 'string,string.quoted',
          'Tag'          => 'entity.name.tag',
          'Title'        => Coloration::Style.new(:fg => ui['foreground'], :bold => true),
          'Type'         => 'entity.name.type',
          'Underlined'   => Coloration::Style.new(:underline => true),
          'WarningMsg'   => 'invalid',

          # ruby
          'rubyBlockParameter'         => 'variable.parameter',
          'rubyClass'                  => 'keyword.controll.class.ruby',
          'rubyClassVariable'          => 'variable',
          'rubyConstant'               => 'support.class',
          'rubyControl'                => 'keyword.control',
          'rubyEscape'                 => 'constant.character.escape',
          'rubyException'              => 'keyword.other.special-method.ruby',
          'rubyFunction'               => 'entity.name.function.ruby',
          'rubyGlobalVariable'         => 'variable.other',
          'rubyInclude'                => 'keyword.other.special-method.ruby',
          'rubyInstanceVariable'       => 'variable.language',
          'rubyInterpolationDelimiter' => '',
          'rubyOperator'               => 'keyword.operator',
          'rubyPseudoVariable'         => 'variable.language.ruby',
          'rubyRegexp'                 => 'string.regexp',
          'rubyRegexpDelimiter'        => 'string.regexp',
          'rubyStringDelimiter'        => 'string,string.quoted',
          'rubySymbol'                 => 'constant.other.symbol.ruby',

          # rails
          'rubyRailsARAssociationMethod' => 'support.function.activerecord.rails',
          'rubyRailsARMethod'            => 'support.function.activerecord.rails',
          'rubyRailsMethod'              => 'support.function',
          'rubyRailsRenderMethod'        => 'support.function',
          'rubyRailsUserClass'           => 'support.class.ruby',

          # eruby
          'erubyComment'     => 'comment',
          'erubyDelimiter'   => 'punctuation.section.embedded.ruby',
          'erubyRailsMethod' => 'support.function',
          # 'erubyExpression'  => 'text.html.ruby source',
          # 'erubyDelimiter'   => '',

          # html
          'htmlArg'         => 'meta.tag entity',
          'htmlEndTag'      => 'meta.tag entity',
          'htmlSpecialChar' => 'constant.character.entity.html',
          'htmlTag'         => 'meta.tag entity',
          'htmlTagName'     => 'meta.tag entity',

          # javascript
          'javaScriptBraces'        => 'meta.brace.curly.js',
          'javaScriptFunction'      => 'storage.type.function.js',
          'javaScriptRailsFunction' => 'support.function',

          # yaml
          'yamlAlias'          => 'variable.other.yaml',
          'yamlAnchor'         => 'variable.other.yaml',
          'yamlDocumentHeader' => 'string.unquoted.yaml',
          'yamlKey'            => 'entity.name.tag.yaml',

          # css
          'cssBraces'        => 'punctuation.section.property-list.css',
          'cssClassName'     => 'entity.other.attribute-name.class.css',
          'cssColor'         => 'constant.other.color.rgb-value.css',
          'cssCommonAttr'    => 'support.constant.property-value.css',
          'cssFunctionName'  => 'support.function.misc.css',
          'cssPseudoClassId' => 'entity.other.attribute-name.pseudo-class.css',
          'cssURL'           => 'variable.parameter.misc.css',
          'cssValueLength'   => 'constant.numeric.css',
        }

        items_mapping.keys.each do |key|
          store(format_item(key, items_mapping[key] || default_style))
        end

        retrieve
      end

      private

      # @!attribute [r] converter
      # @return [void]
      # @todo
      attr_reader :converter

      # @param name []
      # @param style_or_item_name []
      # @return [void]
      # @todo
      def format_item(name, style_or_item_name)
        fail RuntimeError, "Coloration::Style for #{name} is missing!" unless style_or_item_name

        if style_or_item_name == :inverse
          "hi #{name} gui=inverse"
        else
          style = if style_or_item_name.is_a?(Coloration::Style)
            style_or_item_name
          else
            # @items[style_or_item_name]
          end
          "hi #{name} #{format_style(style)}"
        end
      end

      # @param style []
      # @return [String]
      # @todo
      def format_style(style)
        style ||= Coloration::Style.new

        if fg = style.foreground
          ctermfg = rgb_to_xterm256(fg)
          guifg   = fg.html
        else
          ctermfg = 'NONE'
          guifg   = 'NONE'
        end

        if bg = style.background
          ctermbg = rgb_to_xterm256(bg)
          guibg   = bg.html
        else
          ctermbg = 'NONE'
          guibg   = 'NONE'
        end

        gui_attrs = [
          style.inverse   && 'inverse',
          style.bold      && 'bold',
          style.underline && 'underline',
          style.italic    && 'italic'
        ].compact

        cterm_attrs = gui_attrs.reject { |a| a == 'italic' }

        gui   = gui_attrs.empty?   ? 'NONE' : gui_attrs.join(',')
        cterm = cterm_attrs.empty? ? 'NONE' : cterm_attrs.join(',')

        "ctermfg=#{ctermfg} ctermbg=#{ctermbg} cterm=#{cterm} " \
        "guifg=#{guifg} guibg=#{guibg} gui=#{gui}"
      end

      # @param c []
      # @return [Fixnum]
      # @todo
      def rgb_to_xterm256(c)
        a_r = (c.r * 255.0).to_i
        a_g = (c.g * 255.0).to_i
        a_b = (c.b * 255.0).to_i

        return 0 if a_r == 0 && a_g == 0 && a_b == 0

        return 15 if a_r == 255 && a_g == 255 && a_b == 255

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

      # @param v []
      # @param colors []
      # @return [void]
      # @todo
      def get_nearest_xterm_color(v, colors)
        0.upto(colors.size - 2) do |i|
          return colors[i] if v <= (colors[i] + colors[i+1]) / 2
        end

        colors.last
      end

    end # Vim

  end # Writers

end # Coloration
