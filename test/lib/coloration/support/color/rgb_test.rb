require 'test_helper'

module Coloration

  module Color

    describe RGB do

      let(:described) { Coloration::Color::RGB }
      let(:instance)  { described.new(r, g, b) }
      let(:r)         { 32 }
      let(:g)         { 64 }
      let(:b)         { 128 }

      describe '.from_html' do
        let(:html_colour) { '#a5d713' }

        subject { described.from_html(html_colour) }

        it { skip }
      end

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@r').must_equal(r / 255.0) }
        it { subject.instance_variable_get('@g').must_equal(g / 255.0) }
        it { subject.instance_variable_get('@b').must_equal(b / 255.0) }
      end

      describe '#==' do
        let(:other) {}

        subject { instance.==(other) }
      end

      describe '#brightness' do
        subject { instance.brightness }
      end

      describe '#to_yiq' do
        subject { instance.to_yiq }
      end

      describe '#html' do
        subject { instance.html }
      end

      describe '#mix_with' do
        let(:mask)    {}
        let(:opacity) {}

        subject { instance.mix_with(mask, opacity) }
      end

      describe '#r=' do
        subject { instance.r=(rr) }

        context 'when > 1' do
          let(:rr) { 4 }

          # it { subject.must_equal(1.0) }
        end

        context 'when < 0' do
          let(:rr) { -3 }

          # it { subject.must_equal(0.0) }
        end

        context 'when between 0 and 1' do
          let(:rr) { 0.6 }

          it { subject.must_equal(0.6) }
        end
      end

      describe '#g=' do
        subject { instance.g=(gg) }

        context 'when > 1' do
          let(:gg) { 6 }

          # it { subject.must_equal(1.0) }
        end

        context 'when < 0' do
          let(:gg) { -1 }

          # it { subject.must_equal(0.0) }
        end

        context 'when between 0 and 1' do
          let(:gg) { 0.4 }

          it { subject.must_equal(0.4) }
        end
      end

      describe '#b=' do
        subject { instance.b=(bb) }

        context 'when > 1' do
          let(:bb) { 2 }

          # it { subject.must_equal(1.0) }
        end

        context 'when < 0' do
          let(:bb) { -6 }

          # it { subject.must_equal(0.0) }
        end

        context 'when between 0 and 1' do
          let(:bb) { 0.2 }

          it { subject.must_equal(0.2) }
        end
      end

    end # RGB

  end # Color

end # Coloration
