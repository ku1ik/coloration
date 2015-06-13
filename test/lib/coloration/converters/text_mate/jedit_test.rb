require 'test_helper'

module Coloration

  module Converters

    module TextMate

      describe JEdit do

        let(:described) { Coloration::Converters::TextMate::JEdit }
        let(:instance)  { described.new }

        describe '#from' do
          it { instance.from.must_equal('TextMate') }
        end

        describe '#from_type' do
          it { instance.from_type.must_equal('tmTheme') }
        end

        describe '#to' do
          it { instance.to.must_equal('JEdit') }
        end

        describe '#to_type' do
          it { instance.to_type.must_equal('jedit-scheme') }
        end

        describe '#writer' do
          it { instance.writer.must_equal(Coloration::Writers::JEdit) }
        end

      end # JEdit

    end # TextMate

  end # Converters

end # Coloration
