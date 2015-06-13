module Coloration

  module Writers

    class KatePart

      include Coloration::Writers::AbstractWriter

      # @!attribute [r] from
      # @return [String]
      attr_reader :from

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      # @!attribute [r] ui
      # @return [String]
      attr_reader :ui

      # @param input [String]
      # @param converter []
      # @param from [String]
      # @param name [String]
      # @param ui []
      # @return [Coloration::Writers::KatePart]
      # @todo
      def initialize(input, converter, from, name, ui)
        @input     = input
        @converter = converter
        @from      = from
        @name      = name
        @ui        = ui
      end

      # @return [String]
      def translate
        Coloration.log('Writers::KatePart#translate')

        add_comment comment_message
        add_comment "-" * 20 + " Put following in katesyntaxhighlightingrc " + "-" * 20
        store

        store "[Default Item Styles - Schema #{converter.name}]"

        @default_style = Style.new
        @default_style.foreground = @ui["foreground"]

        items_mapping = {
          'Alert'          => @items['invalid'],
          'Base-N Integer' => @items['constant.numeric'],
          'Character'      => @items['keyword.operator'],
          'Comment'        => @items['comment'],
          'Data Type'      => @items['entity.name.type'] || @items['entity.name.class'],
          'Decimal/Value'  => @items['constant.numeric'],
          'Error'          => @items['invalid'],
          'Floating Point' => @items['constant.numeric'],
          'Function'       => @items['entity.name.function'],
          'Keyword'        => @items['keyword'],
          'Normal'         => nil,
          'Others'         => nil,
          'Region Marker'  => nil,
          'String'         => @items['string,string.quoted']
        }

        items_mapping.keys.each do |key|
          store(format_item(key, items_mapping[key] || @default_style))
        end

        store

        store "[Highlighting Ruby - Schema #{converter.name}]"
        store 'Ruby:Access Control=0,' + format_style(@items['storage.modifier'])
        store 'Ruby:Command=0,' + format_style(@items['string.interpolated'])
        store 'Ruby:Constant=0,' + format_style(@items['constant'])
        store 'Ruby:Constant Value=0,' + format_style(@items['constant.other'])
        store 'Ruby:Default globals=0,' + format_style(@items['variable.other'])
        store 'Ruby:Definition=0,' + format_style(@items['entity.name.function'])
        store 'Ruby:Delimiter=0,' + format_style(@items['keyword.other'])
        store 'Ruby:Global Constant=0,' + format_style(@items['constant.other'])
        store 'Ruby:Global Variable=0,' + format_style(@items['variable.other'])
        store 'Ruby:Instance Variable=0,' + format_style(@items['variable'])
        store 'Ruby:Class Variable=0,' + format_style(@items['variable'])
        store 'Ruby:Kernel methods=0,' + format_style(@items['support.function'])
        store 'Ruby:Member=0,' + format_style(@items['entity.name.function'])
        store 'Ruby:Message=0,' + format_style(@default_style)
        store 'Ruby:Operator=0,' + format_style(@items['keyword.operator'])
        store 'Ruby:Pseudo variable=0,' + format_style(@items['variable.language'])
        store 'Ruby:Raw String=0,' + format_style(@items['string.quoted.single'])
  #       store 'Ruby:Region Marker=7,' + format_style(@items['])
        store 'Ruby:Regular Expression=0,' + format_style(@items['string.regexp.ruby'])
        store 'Ruby:Symbol=0,' + format_style(@items['constant.other.symbol.ruby'])

        store

        store "[Highlighting JavaScript - Schema #{converter.name}]"
        store 'JavaScript:Objects=0,' + format_style(@items['variable.language'])

        store

        store "[Highlighting Ruby/Rails/RHTML - Schema #{converter.name}]"
        store 'Ruby/Rails/RHTML:Message=0,' + format_style(@default_style)
        store 'Ruby/Rails/RHTML:Raw String=0,' + format_style(@items['string.quoted.single'])
        store 'Ruby/Rails/RHTML:Symbol=0,' + format_style(@items['constant.other.symbol.ruby'])
        store 'Ruby/Rails/RHTML:Value=0,' + format_style(@items['string,string.quoted'])
        store 'Ruby/Rails/RHTML:Element=0,' + format_style(@items['meta.tag'] || @items['entity.name.tag'])
        store 'Ruby/Rails/RHTML:Kernel methods=0,' + format_style(@items['support.function'])
        store 'Ruby/Rails/RHTML:Attribute=0,' + format_style(@items['entity.other.attribute-name'])

        store

        store "[Highlighting XML - Schema #{converter.name}]"
        store 'XML:Value=0,' + format_style(@items['string,string.quoted'])
        store 'XML:Element=0,' + format_style(@items['meta.tag'] || @items['entity.name.tag'])
        store 'XML:Attribute=0,' + format_style(@items['entity.other.attribute-name'])

        store
        add_comment '-' * 20 + ' Put following in kateschemarc ' + '-' * 20
        store

        store "[#{converter.name}]"

        ui_mapping = {
          'Color Background'            => @ui['background'],
          'Color Highlighted Bracket'   => @ui['background'],
          'Color Highlighted Line'      => @ui['lineHighlight'],
          # 'Color Icon Bar' => @ui[:background],
          # 'Color Line Number' => :,
          # 'Color MarkType1' => :,
          # 'Color MarkType2' => :,
          # 'Color MarkType3' => :,
          # 'Color MarkType4' => :,
          # 'Color MarkType5' => :,
          # 'Color MarkType6' => :,
          # 'Color MarkType7' => :,
          'Color Selection'             => @ui['selection'],
          'Color Tab Marker'            => @ui['invisibles'],
          # 'Color Template Background' => :,
          # 'Color Template Editable Placeholder' => :,
          # 'Color Template Focused Editable Placeholder' => :,
          # 'Color Template Not Editable Placeholder' => :,
          'Color Word Wrap Marker'      => @ui['invisibles']
        }
        ui_mapping.keys.each do |key|
          store "#{key}=#{hex2rgb(ui_mapping[key])}"
        end

        retrieve
      end

      private

      # @!attribute [r] converter
      # @return [void]
      # @todo
      attr_reader :converter

      # @param comment [String]
      # @return [void]
      # @todo
      def add_comment(comment)
        store("# #{comment}")
      end

      # @param style []
      # @return [void]
      # @todo
      def format_style(style)
        style ||= @default_style
        # normal,selected,bold,italic,strike,underline,bg,bg_selected,---
        s = []
        s << (style.foreground || @default_style.foreground).html.gsub('#', '')
        s << (style.foreground || @default_style.foreground).html.gsub('#', '')
        s << style.bold.to_i
        s << style.italic.to_i
        s << style.strike.to_i
        s << style.underline.to_i
        s << (style.background ? style.background.html.gsub('#', '') : nil)
        s << nil
        s << '---'
        s.join(',')
      end

      # @param col []
      # @return [String]
      def hex2rgb(col)
        "#{(col.r*255).to_i},#{(col.g*255).to_i},#{(col.b*255).to_i}"
      end

    end # KatePart

  end # Writers

end # Coloration
