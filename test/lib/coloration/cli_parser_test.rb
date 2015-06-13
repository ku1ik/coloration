require 'test_helper'

module Coloration

  describe CLIParser do

    let(:described) { Coloration::CLIParser }
    let(:instance)  { described.new(reader, argv) }
    let(:reader)    {}
    let(:argv)      {}

    before do
      STDERR.stubs(:puts)
      STDOUT.stubs(:puts)

      # remove this stub when we have completed Parser
      Coloration::Parser.stubs(:process).returns(true)
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@reader').must_equal(reader) }
      it { instance.instance_variable_get('@argv').must_equal(argv) }
    end

    describe '#process' do
      subject { instance.process }

      context 'when arguments are given' do
        let(:argv) { [:source, :destination] }

        context 'when no reader is given' do
          it { proc { subject }.must_raise(NoReaderError) }
        end

        context 'when a reader is given but the theme was not parsed' do
          let(:reader) { Coloration::Converters::TextMate::Vim.new }

          context 'when the theme was not parsed' do
            # it { proc { subject }.must_raise(InvalidThemeError) }
          end
        end

        context 'when the TextMate to JEdit reader is given' do
          let(:reader) { Coloration::Converters::TextMate::JEdit.new }

          it {
            skip
            Coloration::Parser.expects(:process).with(destination: '',
                                                      reader:      '',
                                                      source:      '',
                                                      writer:      nil)
            subject
          }
        end

        context 'when the TextMate to KatePart reader is given' do
          let(:reader) { Coloration::Converters::TextMate::KatePart.new }

          it { skip }
        end

        context 'when the TextMate to Vim reader is given' do
          let(:reader) { Coloration::Converters::TextMate::Vim.new }

          it { skip }
        end
      end

      context 'when no arguments are given' do
        context 'and no reader is given' do
          it { proc { subject }.must_raise(NoReaderError) }
        end

        context 'but a reader is given' do
          let(:reader) { Coloration::Converters::TextMate::Vim.new }

          it { subject.must_equal('Usage: -e <in TextMate theme> [out Vim theme]') }
        end
      end

    end

  end # CLIParser

end # Coloration
