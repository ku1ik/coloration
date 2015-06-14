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

        it { skip }
      end

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@y').must_equal(0.1) }
        it { subject.instance_variable_get('@i').must_equal(0.2) }
        it { subject.instance_variable_get('@q').must_equal(0.3) }
      end

      describe '#==' do
        let(:other) {}

        subject { instance.==(other) }

        it { skip }
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
        let(:yy) { 0.5 }

        subject { instance.y=(yy) }

        it {
          Coloration::Normalize.expects(:[]).with(yy)
          subject
        }
      end

      describe '#i=' do
        let(:ii) { 0.4 }

        subject { instance.i=(ii) }

        it {
          Coloration::Normalize.expects(:[]).with(ii)
          subject
        }
      end

      describe '#q=' do
        let(:qq) { 0.7 }

        subject { instance.q=(qq) }

        it {
          Coloration::Normalize.expects(:[]).with(qq)
          subject
        }
      end

    end # YIQ

  end # Color

end # Coloration
