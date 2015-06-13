require 'test_helper'

module Coloration

  describe Parser do

    let(:this_directory) { File.dirname(__FILE__) }

    let(:described)   { Coloration::Parser }
    let(:instance)    {
      described.new(destination: destination,
                    reader:      reader,
                    source:      source,
                    writer:      writer) }
    let(:source)      { this_directory + '/../../support/Brogrammer.tmTheme'}
    let(:destination) { this_directory + '/../../support/Brogrammer.vim' }
    let(:reader)      { Coloration::Converters::TextMate::Vim }
    let(:writer)      { Coloration::Writers::Vim }
    let(:expected)    {
      File.read(this_directory + '/../../support/working_Brogrammer.vim')
    }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@destination').must_equal(destination) }
      it { subject.instance_variable_get('@reader').must_equal(reader) }
      it { subject.instance_variable_get('@source').must_equal(source) }
      it { subject.instance_variable_get('@writer').must_equal(writer) }
    end

    describe '#process' do
      subject { instance.process }

      context 'when the all the required attributes are given' do
        context 'but the reader does not have a writer' do
          let(:reader) { Coloration::Converters::TextMate::Vim }

          # context 'but has no writer defined' do
          #   before do
          #     Coloration::Readers::TextMate.new('', reader).stubs(:writer)
          #   end

          #   it { proc { subject }.must_raise(NoWriterError) }
          # end
        end

        context 'when the reader is handling TextMate files' do
          let(:reader) { Coloration::Converters::TextMate::Vim }

          # it { subject.must_equal(expected) }
        end

        context 'when the reader is handling...' do
          let(:reader) {}

          it { skip }
        end
      end

      context 'when the destination is not given' do
        let(:destination) {}

        it { proc { subject }.must_raise(NoDestinationError) }
      end

      context 'when the reader is not given' do
        let(:reader) {}

        it { proc { subject }.must_raise(NoReaderError) }
      end

      context 'when the source is not given' do
        let(:source) {}

        it { proc { subject }.must_raise(NoSourceError) }
      end

    end

  end # Parser

end # Coloration
