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
        subject { described.from_html(html_colour) }

        context 'with no colour' do
          let(:html_colour) { '' }

          it { subject.must_be_instance_of(NilClass) }
        end

        context 'with a short CSS form colour' do
          let(:html_colour) { '#ad1' }

          it {
            Coloration::Color::RGB.expects(:new).with(170, 221, 17)
            subject
          }
        end

        context 'with a normal CSS form colour' do
          let(:html_colour) { '#a5d713' }

          it {
            Coloration::Color::RGB.expects(:new).with(165, 215, 19)
            subject
          }
        end

        context 'with an invalid colour' do
          let(:html_colour) { :invalid }

          it { proc { subject }.must_raise(ArgumentError) }
        end
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

        it { skip }
      end

      describe '#brightness' do
        subject { instance.brightness }

        it { skip }
      end

      describe '#to_yiq' do
        subject { instance.to_yiq }

        it { skip }
      end

      describe '#html' do
        subject { instance.html }

        it { skip }
      end

      describe '#mix_with' do
        let(:mask)    {}
        let(:opacity) {}

        subject { instance.mix_with(mask, opacity) }

        it { skip }
      end

      describe '#r=' do
        let(:rr) { 0.5 }

        subject { instance.r=(rr) }

        it {
          Coloration::Normalize.expects(:[]).with(rr)
          subject
        }
      end

      describe '#g=' do
        let(:gg) { 0.4 }

        subject { instance.g=(gg) }

        it {
          Coloration::Normalize.expects(:[]).with(gg)
          subject
        }
      end

      describe '#b=' do
        let(:bb) { 0.7 }

        subject { instance.b=(bb) }

        it {
          Coloration::Normalize.expects(:[]).with(bb)
          subject
        }
      end

    end # RGB

  end # Color

end # Coloration
