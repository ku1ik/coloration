require 'test_helper'

module Coloration

  module Color

    describe XTerm256 do

      let(:described) { Coloration::Color::XTerm256 }
      let(:instance)  { described.new(c) }
      let(:c)         {}

      describe '#initialize' do
        subject { instance }
      end

      describe '.rgb_to_xterm256' do
        it { described.must_respond_to(:rgb_to_xterm256) }
      end

      describe '#rgb_to_xterm256' do
        let(:c) {}

        subject { instance.rgb_to_xterm256(c) }

        context 'when the colour has a alpha channel' do
          it { skip }
        end
      end

    end # Xterm256

  end # Color

end # Coloration
