require 'test_helper'

module Coloration

  module Color

    describe XTerm256 do

      let(:described) { Coloration::Color::XTerm256 }
      let(:instance)  { described.new(color) }
      let(:color)     { Coloration::Color::RGB.new(160, 210, 20) }

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@color').must_equal(color) }
      end

      describe '.rgb_to_xterm256' do
        it { described.must_respond_to(:rgb_to_xterm256) }
      end

      describe '#rgb_to_xterm256' do
        subject { instance.rgb_to_xterm256 }

        it { subject.must_be_instance_of(Fixnum) }
      end

    end # Xterm256

  end # Color

end # Coloration
