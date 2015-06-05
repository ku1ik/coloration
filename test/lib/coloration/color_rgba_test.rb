require 'test_helper'

module Color

  describe RGBA do

    let(:described) { Color::RGBA }

    describe '.from_html' do
      let(:col) { '#aadd00ff' }
      let(:bg)  {}

      subject { described.from_html(col, bg) }

      context 'when the colour has a alpha channel' do
        it { skip }
      end

      context 'when the colour does not have an alpha channel' do
        let(:col) { '#aadd00ff' }

        it { skip }
      end
    end

  end # RGBA

end # Color
