require 'test_helper'

module Coloration

  module Converters

    module TextMate

      describe Vim do

        let(:described) { Coloration::Converters::TextMate::Vim }
        let(:instance)  { described.new }

        describe '#from' do
          it { instance.from.must_equal('TextMate') }
        end

        describe '#from_type' do
          it { instance.from_type.must_equal('tmTheme') }
        end

        describe '#to' do
          it { instance.to.must_equal('Vim') }
        end

        describe '#to_type' do
          it { instance.to_type.must_equal('vim') }
        end

        describe '#writer' do
          it { instance.writer.must_equal(Coloration::Writers::Vim) }
        end

      end # Vim

    end # TextMate

  end # Converters

end # Coloration
