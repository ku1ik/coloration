require 'test_helper'

module Coloration

  module Readers

    describe TextMateThemeReader do

      let(:described) { Coloration::Readers::TextMateThemeReader }
      let(:instance)  {}

      describe '#parse_input' do
        subject { instance.parse_input }

        context 'when a valid tmTheme is given' do
        end

        # @todo
        context 'when an invalid tmTheme is given' do
          it { skip; proc { subject }.must_raise(Coloration::Readers::TextMateThemeReader::InvalidThemeError) }
        end

        # @todo
        context 'when no tmTheme is given' do
          it { skip; proc { subject }.must_raise(Coloration::Readers::TextMateThemeReader::InvalidThemeError) }
        end
      end

      describe '#name' do
        subject { instance.name }
      end

      describe '#ui' do
        subject { instance.ui }
      end

    end # TextMateThemeReader

  end # Readers

end # Coloration
