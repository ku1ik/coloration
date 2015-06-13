require 'test_helper'

module Coloration

  module Color

    describe RGB do

      let(:described) { Coloration::Color::RGB }

      describe '.from_html' do
        let(:col) { '#aadd00' }
        let(:bg)  {}

        subject { described.from_html(col, bg) }

        it { skip }
      end

    end # RGBA

  end # Color

end # Coloration
