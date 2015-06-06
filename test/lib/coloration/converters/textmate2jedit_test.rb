require 'test_helper'

module Coloration

  module Converters

    describe Textmate2JEditConverter do

      let(:described) { Coloration::Converters::Textmate2JEditConverter }
      let(:instance) { described.new }

      describe '#in_theme_type' do
        it { instance.in_theme_type.must_equal('Textmate') }
      end

      describe '#in_theme_ext' do
        it { instance.in_theme_ext.must_equal('tmTheme') }
      end

      describe '#out_theme_type' do
        it { instance.out_theme_type.must_equal('JEdit') }
      end

      describe '#out_theme_ext' do
        it { instance.out_theme_ext.must_equal('jedit-scheme') }
      end

    end # Textmate2JEditConverter

  end # Converters

end # Coloration
