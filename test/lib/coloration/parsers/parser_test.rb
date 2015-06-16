require 'test_helper'

module Coloration

  describe Parser do

    let(:this_directory) { File.dirname(__FILE__) }

    let(:described)   { Coloration::Parser }
    let(:instance)    {
      described.new(destination: destination,
                    converter:   converter,
                    source:      source,
                    writer:      writer) }
    let(:source)      { this_directory + '/../../../support/Brogrammer.tmTheme'}
    let(:destination) { this_directory + '/../../../support/Brogrammer.vim' }
    let(:converter)   { Coloration::Converters::TextMate::Vim.new }
    let(:writer)      { Coloration::Writers::Vim }
    let(:expected)    {
      File.read(this_directory + '/../../../support/working_Brogrammer.vim')
    }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@destination').must_equal(destination) }
      it { subject.instance_variable_get('@converter').must_equal(converter) }
      it { subject.instance_variable_get('@source').must_equal(source) }
      it { subject.instance_variable_get('@writer').must_equal(writer) }
    end

    describe '#process' do
      subject { instance.process }

      context 'when the all the required attributes are given' do
        context 'but the converter does not have a writer' do
          let(:converter) { Coloration::Converters::TextMate::Vim.new }

          # context 'but has no writer defined' do
          #   before do
          #     Coloration::Readers::TextMate.new('', converter).stubs(:writer)
          #   end

          #   it { proc { subject }.must_raise(NoWriterError) }
          # end
          it { skip }
        end

        context 'when the converter is handling TextMate files' do
          let(:converter) { Coloration::Converters::TextMate::Vim.new }

          # it { subject.must_equal(expected) }
          it { skip }
        end

        context 'when the converter is handling...' do
          let(:converter) {}

          it { skip }
        end
      end

      context 'when the destination is not given' do
        let(:destination) {}

        it { proc { subject }.must_raise(NoDestinationError) }
      end

      context 'when the converter is not given' do
        let(:converter) {}

        it { proc { subject }.must_raise(NoConverterError) }
      end

      context 'when the source is not given' do
        let(:source) {}

        it { proc { subject }.must_raise(NoSourceError) }
      end

    end

  end # Parser

end # Coloration
