module Coloration

  module Writers

    class JEdit

      include Coloration::Writers::AbstractWriter

      # @param input []
      # @param reader []
      # @return [String]
      # @todo
      def initialize(input, reader)
        @input  = input
        @reader = reader
      end

      # @return [String]
      def translate
        Coloration.log('Writers::JEdit#translate')

        store("\# #{comment_message}")
        store

        ui_mapping = {
          'scheme.name'             => @name,
          'view.fgColor'            => @ui['foreground'],
          'view.bgColor'            => @ui['background'],
          'view.caretColor'         => @ui['caret'],
          'view.selectionColor'     => @ui['selection'],
          'view.eolMarkerColor'     => @ui['invisibles'],
          'view.lineHighlightColor' => @ui['lineHighlight'],
        }

        ui_mapping.keys.each do |key|
          store(format_ui(key, ui_mapping[key]))
        end

        items_mapping = {
          'view.style.comment1'     => @items['comment'], # #foo
          'view.style.literal1'     => @items['string,string.quoted'], # 'foo'
          'view.style.label'        => @items['constant.other.symbol'], # :foo
          'view.style.digit'        => @items['constant.numeric'], # 123
          'view.style.keyword1'     => @items['keyword.control'], # class, def, if, end
          'view.style.keyword2'     => @items['support.function'], # require, include
          'view.style.keyword3'     => @items['constant.language'], # true, false, nil
          'view.style.keyword4'     => @items['variable.other'], # @foo
          'view.style.operator'     => @items['keyword.operator'], # = < + -
          'view.style.function'     => @items['entity.name.function'], # def foo
          'view.style.literal3'     => @items['string.regexp'], # /jola/
          # 'view.style.invalid' => @items['invalid'], # errors etc
          # 'view.style.literal4' => :constant # MyClass, USER_SPACE
          'view.style.markup'       => @items['meta.tag'] || @items['entity.name.tag'] # <div>
          # TODO: gutter etc
        }

        default_style = Style.new
        default_style.foreground = @ui['foreground']
        items_mapping.keys.each do |key|
          store(format_item(key, items_mapping[key] || default_style))
        end

        retrieve
      end

      private

      # @!attribute [r] reader
      # @return [void]
      # @todo
      attr_reader :reader

      # @param value [String]
      # @return [String]
      def escape(value)
        value.gsub(':', '\:').gsub('#', '\#').strip
      end

      # @param name []
      # @param value []
      # @return [String]
      # @todo
      def format_ui(name, value)
        case value
        when Color::RGB
          value = value.html
        else
          value = value.to_s
        end
        "#{name}=#{escape(value)}"
      end

      # @param style [Style]
      # @return [String]
      def format_style(style)
        s = ''
        s << " color:#{style.foreground.html}" if style.foreground
        s << " bgColor:#{style.background.html}" if style.background

        if s.size > 0
          s << ' style:'
          s << 'b' if style.bold
          s << 'u' if style.underline
          s << 'i' if style.italic
        end
        escape(s)
      end

    end # JEdit

  end # Writers

end # Coloration
