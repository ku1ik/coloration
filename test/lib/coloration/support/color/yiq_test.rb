require 'test_helper'

module Coloration

  module Color

    describe YIQ do

      let(:described) { Coloration::Color::YIQ }
      let(:instance)  { described.new(y, i, q) }
      let(:y)         { 10 }
      let(:i)         { 20 }
      let(:q)         { 30 }

      describe '.from_fraction' do
        subject { described.from_fraction(y, i, q) }
      end

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@y').must_equal(0.1) }
        it { subject.instance_variable_get('@i').must_equal(0.2) }
        it { subject.instance_variable_get('@q').must_equal(0.3) }
      end

      describe '#==' do
      end

      describe '#to_yiq' do
        subject { instance.to_yiq }

        it { subject.must_be_instance_of(described) }
        it { subject.must_equal(instance) }
      end

      describe '#brightness' do
        subject { instance.brightness }

        it { subject.must_equal(0.1) }
      end

      describe '#y=' do
        subject { instance.y=(yy) }

        context 'when > 1' do
          let(:yy) { 4 }

          # it { subject.must_equal(1.0) }
        end

        context 'when < 0' do
          let(:yy) { -3 }

          # it { subject.must_equal(0.0) }
        end

        context 'when between 0 and 1' do
          let(:yy) { 0.6 }

          it { subject.must_equal(0.6) }
        end
      end

      describe '#i=' do
        subject { instance.i=(ii) }

        context 'when > 1' do
          let(:ii) { 6 }

          # it { subject.must_equal(1.0) }
        end

        context 'when < 0' do
          let(:ii) { -1 }

          # it { subject.must_equal(0.0) }
        end

        context 'when between 0 and 1' do
          let(:ii) { 0.4 }

          it { subject.must_equal(0.4) }
        end
      end

      describe '#q=' do
        subject { instance.q=(qq) }

        context 'when > 1' do
          let(:qq) { 2 }

          # it { subject.must_equal(1.0) }
        end

        context 'when < 0' do
          let(:qq) { -6 }

          # it { subject.must_equal(0.0) }
        end

        context 'when between 0 and 1' do
          let(:qq) { 0.2 }

          it { subject.must_equal(0.2) }
        end
      end

    end # YIQ

  end # Color

end # Coloration
