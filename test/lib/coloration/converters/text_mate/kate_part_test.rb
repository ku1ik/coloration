require 'test_helper'

module Coloration

  module Converters

    module TextMate

      describe KatePart do

        let(:described) { Coloration::Converters::TextMate::KatePart }
        let(:instance)  { described.new }

        describe '#from' do
          it { instance.from.must_equal('TextMate') }
        end

        describe '#from_type' do
          it { instance.from_type.must_equal('tmTheme') }
        end

        describe '#to' do
          it { instance.to.must_equal('KatePart') }
        end

        describe '#to_type' do
          it { instance.to_type.must_equal('txt') }
        end

        describe '#writer' do
          it { instance.writer.must_equal(Coloration::Writers::KatePart) }
        end

      end # KatePart

    end # TextMate

  end # Converters

end # Coloration
