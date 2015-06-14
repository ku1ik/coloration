require 'test_helper'

module Coloration

  describe Normalize do

    let(:described) { Coloration::Normalize }
    let(:instance)  { described.new(_value) }
    let(:_value)    { 0.5 }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@value').must_equal(_value) }
    end

    describe '.[]' do
      it { described.must_respond_to(:[]) }
    end

    describe '#[]' do
      subject { instance.[] }

      context 'when the value is more than one' do
        let(:_value) { 5 }

        it { subject.must_equal(1.0) }
      end

      context 'when the value is less than zero' do
        let(:_value) { -4 }

        it { subject.must_equal(0.0) }
      end

      context 'when the value is between zero and one' do
        it { subject.must_equal(_value) }
      end
    end

  end # Normalize

end # Coloration
