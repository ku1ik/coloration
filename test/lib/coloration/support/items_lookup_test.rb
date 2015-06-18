require 'test_helper'

module Coloration

  describe ItemsLookup do

    let(:described) { Coloration::ItemsLookup }
    let(:instance)  { described.new(items) }
    let(:items)     {
      [
        {
          'name'  => 'Comment',
          'scope' => 'comment',
          'settings' => {
            'foreground' => '#606060',
            :italic => true
          }
        }, {
          'name' => 'Constant',
          'scope' => 'constant',
          'settings' => {
            'foreground' => '#6c71c4'
          }
        }, {
          'name' => 'Entity',
          'scope' => 'entity',
          'settings' => {
            'foreground' => '#2ecc71'
          }
        }, {
          'name' => 'Keyword',
          'scope' => 'keyword',
          'settings' => {
            'foreground' => '#e74c3c',
            :bold => true
          }
        }, {
          'name' => 'Storage',
          'scope' => 'storage',
          'settings' => {
            'foreground' => '#3498db'
          }
        }, {
          'name' => 'String',
          'scope' => 'string',
          'settings' => {
            'foreground' => '#f1c40f'
          }
        }, {
          'name' => 'Support',
          'scope' => 'support',
          'settings' => {
            'foreground' => '#3498db',
            :bold => true
          }
        }, {
          'name' => 'Variable',
          'scope' => 'variable',
          'settings' => {
            'foreground' => '#e67e22'
          }
        }, {
          'name' => 'Invalid',
          'scope' => 'invalid',
          'settings' => {
            'background' => '#e74c3c',
            'foreground' => '#ffffff'
          }
        }, {
          'name' => 'Embedded Source',
          'scope' => 'text source',
          'settings' => {
            'background' => ''
          }
        }, {
          'name' => 'Embedded Source (Bright)',
          'scope' => 'text.html.ruby source',
          'settings' => {
            'background' => '#'
          }
        }, {
          'name' => 'Entity inherited-class',
          'scope' => 'entity.other.inherited-class',
          'settings' => {
            'foreground' => '#2ecc71',
            :italic => true
          }
        }, {
          'name' => 'String embedded-source',
          'scope' => 'string.quoted source',
          'settings' => {
            'foreground' => '#f1c40f'
          }
        }, {
          'name' => 'String constant',
          'scope' => 'string constant',
          'settings' => {
            'foreground' => '#6c71c4'
          }
        }, {
          'name' => 'String.regexp',
          'scope' => 'string.regexp',
          'settings' => {
            'foreground' => '#3498db'
          }
        }, {
          'name' => 'String variable',
          'scope' => 'string variable',
          'settings' => {
            'foreground' => '#ffffff'
          }
        }, {
          'name' => 'Support.function',
          'scope' => 'support.function',
          'settings' => {
            'foreground' => '#3498db'
          }
        }, {
          'name' => 'Support.constant',
          'scope' => 'support.constant',
          'settings' => {
            'foreground' => '#2ecc71'
          }
        }, {
          'name' => 'C/C++ Preprocessor Line',
          'scope' => 'other.preprocessor.c',
          'settings' => {
            'foreground' => '#3498db'
          }
        }, {
          'name' => 'C/C++ Preprocessor Directive',
          'scope' => 'other.preprocessor.c entity',
          'settings' => {
            'foreground' => '#2ecc71'
          }
        }, {
          'name' => 'Meta.tag.A',
          'scope' => 'declaration.tag, declaration.tag entity, meta.tag, meta.tag entity',
          'settings' => {
            'foreground' => '#e74c3c'
          }
        }, {
          'name' => 'css tag-name',
          'scope' => 'meta.selector.css entity.name.tag',
          'settings' => {
            'foreground' => '#1abc9c'
          }
        }, {
          'name' => 'css#id',
          'scope' => 'meta.selector.css entity.other.attribute-name.id',
          'settings' => {
            'foreground' => '#2ecc71'
          }
        }, {
          'name' => 'css.class',
          'scope' => 'meta.selector.css entity.other.attribute-name.class',
          'settings' => {
            'foreground' => '#2ecc71'
          }
        }, {
          'name' => 'css property-name:',
          'scope' => 'support.type.property-name.css',
          'settings' => {
            'foreground' => '#3498db'
          }
        }, {
          'name' => 'css property-value;',
          'scope' => 'meta.property-group support.constant.property-value.css, meta.property-value support.constant.property-value.css',
          'settings' => {
            'foreground' => '#2ecc71',
            :italic => true
          }
        }, {
          'name' => 'css @at-rule',
          'scope' => 'meta.preprocessor.at-rule keyword.control.at-rule',
          'settings' => {
            'foreground' => '#f1c40f',
            :bold => true
          }
        }, {
          'name' => 'css additional-constants',
          'scope' => 'meta.property-value support.constant.named-color.css, meta.property-value constant',
          'settings' => {
            'foreground' => '#e74c3c'
          }
        }, {
          'name' => 'css constructor.argument',
          'scope' => 'meta.constructor.argument.css',
          'settings' => {
            'foreground' => '#e74c3c'
          }
        }, {
          'name' => 'diff.header',
          'scope' => 'meta.diff, meta.diff.header',
          'settings' => {
            'background' => '#2ecc71',
            'foreground' => '#F8F8F8',
            :italic => true
          }
        }, {
          'name' => 'diff.deleted',
          'scope' => 'markup.deleted',
          'settings' => {
            'background' => '#e74c3c',
            'foreground' => '#F8F8F8'
          }
        }, {
          'name' => 'diff.changed',
          'scope' => 'markup.changed',
          'settings' => {
            'background' => '#e67e22',
            'foreground' => '#F8F8F8'
          }
        }, {
          'name' => 'diff.inserted',
          'scope' => 'markup.inserted',
          'settings' => {
            'background' => '#f1c40f',
            'foreground' => '#F8F8F8'
          }
        }, {
          'name' => 'SublimeLinter Annotations',
          'scope' => 'sublimelinter.outline.notes',
          'settings' => {
            'background' => '#233345'
          }
        }, {
          'name' => 'SublimeLinter Outline',
          'scope' => 'sublimelinter.outline.illegal',
          'settings' => {
            'background' => '#d7503c'
          }
        }, {
          'name' => 'SublimeLinter Underline',
          'scope' => 'sublimelinter.underline.illegal',
          'settings' => {
            'background' => '#d7503c'
          }
        }, {
          'name' => 'SublimeLinter Warning Outline',
          'scope' => 'sublimelinter.outline.warning',
          'settings' => {
            'background' => '#9f3a2c',
            'foreground' => '#ffffff'
          }
        }, {
          'name' => 'SublimeLinter Warning Underline',
          'scope' => 'sublimelinter.underline.warning',
          'settings' => {
            'background' => '#d7503c'
          }
        }, {
          'name' => 'SublimeLinter Violation Outline',
          'scope' => 'sublimelinter.outline.violation',
          'settings' => {
            'background' => '#9f3a2c'
          }
        }, {
          'name' => 'SublimeLinter Violation Underline',
          'scope' => 'sublimelinter.underline.violation',
          'settings' => {
            'background' => '#d7503c'
          }
        }, {
          'name' => 'html id',
          'scope' => 'entity.other.attribute-name.id.html',
          'settings' => {
            'foreground' => '#2ecc71'
          }
        }, {
          'name' => 'html class',
          'scope' => 'entity.other.attribute-name.html',
          'settings' => {
            'foreground' => '#2ecc71'
          }
        }, {
          'name' => 'html punctuations tags',
          'scope' => 'punctuation.definition.tag.end, punctuation.definition.tag.begin, punctuation.definition.tag',
          'settings' => {
            'foreground' => '#fff'
          }
        }, {
          'name' => 'CSS @import',
          'scope' => 'keyword.control.at-rule.import.css',
          'settings' => {
            'foreground' => '#f1c40f',
            :bold => true
          }
        }, {
          'name' => 'LESS variables',
          'scope' => 'variable.other.less',
          'settings' => {
            'foreground' => '#ffffff'
          }
        }, {
          'name' => 'LESS variables',
          'scope' => 'entity.other.less.mixin',
          'settings' => {
            'foreground' => '#9b59b6'
          }
        }, {
          'name' => 'LESS units',
          'scope' => 'source.css.less keyword.unit.css',
          'settings' => {
            'foreground' => '#3498db'
          }
        }, {
          'name' => 'Angular',
          'scope' => 'entity.other.attribute-name.angular.html, source.angular.embedded.html',
          'settings' => {
          'foreground' => '#e74c3c'
        }
        }, {
          'name' => 'HTML Entities',
          'scope' => 'constant.character.entity.html',
          'settings' => {
            'foreground' => '#3498db'
          }
        }, {
          'name' => 'coffee instance var',
          'scope' => 'variable.other.readwrite.instance.coffee',
          'settings' => {
            'foreground' => '#e67e22'
          }
        }, {
          'name' => 'coffee brace',
          'scope' => 'meta.brace.round.coffee,meta.brace.square.coffee',
          'settings' => {
            'foreground' => '#f1c40f'
          }
        }, {
          'name' => 'coffee embeded',
          'scope' => 'punctuation.section.embedded.coffee',
          'settings' => {
            'foreground' => '#5eebb8'
          }
        }, {
          'name' => 'Coffee vars',
          'scope' => 'variable.assignment.coffee variable.assignment.coffee',
          'settings' => {
            'foreground' => '#FFFFFF'
          }
        }, {
          'name' => 'Coffee dots',
          'scope' => 'meta.delimiter.method.period.coffee',
          'settings' => {
            'foreground' => '#3cadd7'
          }
        }, {
          'name' => 'Coffee curleys',
          'scope' => 'meta.brace.curly.coffee',
          'settings' => {
            'foreground' => '#1abc9c'
          }
        }, {
          'name' => 'Doctype/XML Processing',
          'scope' => 'meta.tag.sgml.doctype.xml, declaration.sgml.html declaration.doctype, declaration.sgml.html declaration.doctype entity, declaration.sgml.html declaration.doctype string, declaration.xml-processing, declaration.xml-processing entity, declaration.xml-processing string, doctype',
          'settings' => {
            'foreground' => '#3c444d'
          }
        }]
    }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@items').must_equal(items) }
    end

    describe '#[]' do
      let(:keys) {}

      subject { instance.[](keys) }

      it { skip }
    end

  end # ItemLookup

end # Coloration
