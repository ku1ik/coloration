module Coloration

  module Writers

    class Vim

      extend Forwardable

      def_delegators :reader, :items, :name, :ui
      def_delegators :converter, :from

      include Coloration::Writers::AbstractWriter

      # @!attribute [r] converter
      # @return [String]
      attr_reader :converter

      # @!attribute [r] from
      # @return [String]
      attr_reader :from

      # @!attribute [r] reader
      # @return []
      attr_reader :reader

      # @param input [String]
      # @param converter []
      # @param reader []
      # @return [Coloration::Writers::Vim]
      # @todo
      def initialize(input, converter, reader)
        @input     = input
        @converter = converter
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

        store_ui_mapping

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
          'Normal'       => Coloration::Style.new(:fg => ui['foreground'],
                                                  :bg => ui['background']),
          'Boolean'      => 'constant.language',
          'Character'    => 'constant.character',
          'Comment'      => 'comment',
          'Conditional'  => 'keyword.control',
          'Constant'     => 'constant',
          # 'Debug'          => [],
          'Define'       => 'keyword',
          # 'Delimiter'      => 'meta.separator',
          'DiffAdd'      => Coloration::Style.new(:bg => green.mix_with(ui['background'], 80),
                                                  :fg => ui['foreground'],
                                                  :bold => true),
          'DiffChange'   => Coloration::Style.new(:bg => blue.mix_with(ui['background'], 50),
                                                  :fg => ui['foreground']),
          'DiffDelete'   => Coloration::Style.new(:fg => red.mix_with(ui['background'], 80)),
          'DiffText'     => Coloration::Style.new(:bg => blue.mix_with(ui['background'], 100),
                                                  :fg => ui['foreground'],
                                                  :bold => true),
          'ErrorMsg'     => 'invalid',
          'WarningMsg'   => 'invalid',
          # 'Exception'      => [],
          'Float'        => 'constant.numeric',
          'Function'     => 'entity.name.function',
          'Identifier'   => 'storage.type',
          # 'Include'        => [],
          'Keyword'      => 'keyword',
          'Label'        => 'string.other',
          # 'Macro'          => [],
          'NonText'      => Coloration::Style.new(:fg => ui['invisibles'],
                                                  :bg => ui['background'].mix_with(ui['foreground'], 95)),
          'Number'       => 'constant.numeric',
          'Operator'     => 'keyword.operator',
          # 'PreCondit'      => [],
          'PreProc'      => 'keyword.other',
          # "Repeat"         => [],
          'Special'      => Coloration::Style.new(:fg => ui['foreground']),
          # 'SpecialChar'    => [],
          # 'SpecialComment' => [],
          'SpecialKey'   => Coloration::Style.new(:fg => ui['invisibles'],
                                                  :bg => bg_line_color),
          'Statement'    => 'keyword.control',
          'StorageClass' => 'storage.type',
          'String'       => 'string,string.quoted',
          # 'Structure'      => [],
          'Tag'          => 'entity.name.tag',
          'Title'        => Coloration::Style.new(:fg => ui['foreground'],
                                                  :bold => true),
      # 'Todo'         => (items['comment'] || default_style).clone.tap { |c| c.inverse = true; c.bold = true },
          'Type'         => 'entity.name.type',
          # 'Typedef'        => [],
          'Underlined'   => Coloration::Style.new(:underline => true),

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

      # @return [void]
      # @todo
      def bg_line_color
        @bg_line_color ||= ui['background'].mix_with(ui['foreground'], 90)
      end

      # @return [void]
      # @todo
      def border_color
        @border_color ||= ui['background'].mix_with(ui['foreground'], 71)
      end

      # @return [void]
      # @todo
      def default_value
        @default_value ||= Coloration::Style.new(:fg => ui['foreground'])
      end

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
            # items[style_or_item_name]
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
          ctermfg = Coloration::Color::XTerm256.rgb_to_xterm256(fg)
          guifg   = fg.html
        else
          ctermfg = 'NONE'
          guifg   = 'NONE'
        end

        if bg = style.background
          ctermbg = Coloration::Color::XTerm256.rgb_to_xterm256(bg)
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

      # @return [void]
      def store_ui_mapping
        ui_mapping.keys.each do |key|
          store(format_item(key, ui_mapping[key] || default_style))
        end
      end

      # @return [Hash<String => Coloration::Style, String]
      def ui_mapping
        {
          'Cursor'       => Coloration::Style.new(:fg => ui['background'], :bg => ui['caret']),
          'Visual'       => Coloration::Style.new(:bg => ui['selection']),
          'CursorLine'   => Coloration::Style.new(:bg => bg_line_color),
          'CursorColumn' => Coloration::Style.new(:bg => bg_line_color),
          'ColorColumn'  => Coloration::Style.new(:bg => bg_line_color),
          'LineNr'       => Coloration::Style.new(:fg => ui['foreground'].mix_with(ui['background'], 50), :bg => bg_line_color),
          'VertSplit'    => Coloration::Style.new(:fg => border_color, :bg => border_color),
        # 'MatchParen'   => Coloration::Style.new(:fg => items['keyword'].foreground, :underline => true),
          'StatusLine'   => Coloration::Style.new(:fg => ui['foreground'], :bg => border_color, :bold => true),
          'StatusLineNC' => Coloration::Style.new(:fg => ui['foreground'], :bg => border_color),
          'Pmenu'        => 'entity.name',
          'PmenuSel'     => Coloration::Style.new(:bg => ui['selection']),
        # 'IncSearch'    => Coloration::Style.new(:bg => items['string'].foreground, :fg => ui['background']),
          'Search'       => Coloration::Style.new(:underline => true),
          'Directory'    => 'constant.other.symbol',
        # 'Folded'       => Coloration::Style.new(:fg => items['comment'].try(:foreground), :bg => ui['background']),
        }
      end

    end # Vim

  end # Writers

end # Coloration
