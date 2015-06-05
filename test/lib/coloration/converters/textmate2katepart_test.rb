require 'test_helper'

module Coloration

  module Converters

    describe Textmate2KatePartConverter do

      let(:described) { Coloration::Converters::Textmate2KatePartConverter }
      let(:instance) { described.new }

      describe '#in_theme_type' do
        it { instance.in_theme_type.must_equal('Textmate') }
      end

      describe '#in_theme_ext' do
        it { instance.in_theme_ext.must_equal('tmTheme') }
      end

      describe '#out_theme_type' do
        it { instance.out_theme_type.must_equal('KatePart') }
      end

      describe '#out_theme_ext' do
        it { instance.out_theme_ext.must_equal('txt') }
      end

    end # Textmate2KatePartConverter

  end # Converters

end # Coloration
