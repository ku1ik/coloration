require 'test_helper'

module Coloration

  describe CLIParser do

    let(:described) { Coloration::CLIParser }
    let(:instance)  { described.new(converter, argv) }
    let(:converter) {}
    let(:argv)      {}

    before do
      STDERR.stubs(:puts)
      STDOUT.stubs(:puts)

      # remove this stub when we have completed Parser
      # Coloration::Parser.stubs(:process).returns(true)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@converter').must_equal(converter) }
      it { instance.instance_variable_get('@argv').must_equal(argv) }
    end

    describe '#process' do
      subject { instance.process }

      context 'when arguments are given' do
        let(:argv) { [:source, :destination] }

        context 'when no converter is given' do
          it { proc { subject }.must_raise(NoConverterError) }
        end

        context 'when a converter is given but the theme was not parsed' do
          let(:converter) { Coloration::Converters::TextMate::Vim.new }

          context 'when the theme was not parsed' do
            # it { proc { subject }.must_raise(InvalidThemeError) }
            it { skip }
          end
        end

        context 'when the TextMate to JEdit converter is given' do
          let(:converter) { Coloration::Converters::TextMate::JEdit.new }

          it {
            Coloration::Parser.expects(:process).
              with(destination: :destination,
                   converter:   converter,
                   source:      :source,
                   writer:      Coloration::Writers::JEdit)
            subject
          }
        end

        context 'when the TextMate to KatePart converter is given' do
          let(:converter) { Coloration::Converters::TextMate::KatePart.new }

          it {
            Coloration::Parser.expects(:process).
              with(destination: :destination,
                   converter:   converter,
                   source:      :source,
                   writer:      Coloration::Writers::KatePart)
            subject
          }
        end

        context 'when the TextMate to Vim converter is given' do
          let(:converter) { Coloration::Converters::TextMate::Vim.new }

          it {
            Coloration::Parser.expects(:process).
              with(destination: :destination,
                   converter:   converter,
                   source:      :source,
                   writer:      Coloration::Writers::Vim)
            subject
          }
        end
      end

      context 'when no arguments are given' do
        context 'and no converter is given' do
          it { proc { subject }.must_raise(NoConverterError) }
        end

        context 'but a converter is given' do
          let(:converter) { Coloration::Converters::TextMate::Vim.new }

          it { subject.must_match(/<in TextMate theme> \[out Vim theme\]/) }
        end
      end

    end

  end # CLIParser

end # Coloration
