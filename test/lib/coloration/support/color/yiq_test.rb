require 'test_helper'

module Coloration

  module Color

    describe YIQ do

      let(:described)  { Coloration::Color::YIQ }
      let(:instance)   { described.new(brightness, in_phase, quadrature) }
      let(:brightness) { 0.1 }
      let(:in_phase)   { 0.2 }
      let(:quadrature) { 0.3 }

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@y').must_equal(brightness) }
        it { subject.instance_variable_get('@i').must_equal(in_phase) }
        it { subject.instance_variable_get('@q').must_equal(quadrature) }
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

        it {
          skip
          Coloration::Normalize.expects(:[]).with(brightness)
          subject
        }
        it { instance.must_respond_to(:y) }
      end

      describe '#in_phase' do
        subject { instance.in_phase }

        it {
          skip
          Coloration::Normalize.expects(:[]).with(in_phase)
          subject
        }
        it { instance.must_respond_to(:i) }
      end

      describe '#quadrature' do
        subject { instance.quadrature }

        it {
          skip
          Coloration::Normalize.expects(:[]).with(quadrature)
          subject
        }
        it { instance.must_respond_to(:q) }
      end

      describe '#brightness=' do
        let(:value) { 0.5 }

        subject { instance.brightness=(value) }

        it {
          Coloration::Normalize.expects(:[]).with(value)
          subject
        }
        it { instance.must_respond_to(:y=) }
      end

      describe '#in_phase=' do
        let(:value) { 0.4 }

        subject { instance.in_phase=(value) }

        it {
          Coloration::Normalize.expects(:[]).with(value)
          subject
        }
        it { instance.must_respond_to(:i=) }
      end

      describe '#quadrature=' do
        let(:value) { 0.7 }

        subject { instance.quadrature=(value) }

        it {
          Coloration::Normalize.expects(:[]).with(value)
          subject
        }
        it { instance.must_respond_to(:q=) }
      end

    end # YIQ

  end # Color

end # Coloration
