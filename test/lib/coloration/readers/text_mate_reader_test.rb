require 'test_helper'

module Coloration

  module Readers

    describe TextMateReader do

      let(:directory) { File.dirname(__FILE__) }
      let(:theme)     { '/../../../support/Brogrammer.tmTheme' }

      let(:described) { Coloration::Readers::TextMateReader }
      let(:instance)  { described.new(input, converter) }
      let(:input)     { File.read(directory + theme) }
      let(:converter) { Coloration::Converters::TextMate::Vim }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }
        it { instance.instance_variable_get('@converter').must_equal(converter) }
      end

      describe '.parse' do
        it { described.must_respond_to(:parse) }
      end

      describe '#parse' do
        subject { instance.parse }

        context 'when a valid tmTheme is given' do
        end

        # @todo
        context 'when an invalid tmTheme is given' do
          let(:input) { '' }

          it { proc { subject }.must_raise(Coloration::InvalidThemeError) }
        end

        context 'when no tmTheme is given' do
          let(:input) { '' }

          it { proc { subject }.must_raise(Coloration::NoSourceError) }
        end
      end

      describe '#name' do
        subject { instance.name }

        it { subject.must_equal('Brogrammer') }
      end

      describe '#ui' do
        subject { instance.ui }

        it { subject.must_equal({
          "activeGuide"         => "#ffffff",
          "background"          => "#1a1a1a",
          "caret"               => "#ecf0f1",
          "findHighlight"       => "#e74c3c",
          "foreground"          => "#ecf0f1",
          "guide"               => "#222222",
          "gutter"              => "#2a2a2a",
          "gutterForeground"    => "#ffffff",
          "inactiveSelection"   => "#e74c3c",
          "invisibles"          => "#F3FFB51A",
          "lineHighlight"       => "#2a2a2a",
          "selection"           => "#2a2a2a",
          "selectionForeground" => "#ffffff",
        }) }
      end

    end # TextMateReader

  end # Readers

end # Coloration
