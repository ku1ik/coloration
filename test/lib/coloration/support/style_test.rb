require 'test_helper'

module Coloration

  describe Style do

    let(:described) { Coloration::Style }
    let(:instance)  { described.new(obj, bg) }
    let(:obj)       {}
    let(:bg)        {}

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
    end

    describe '#initialize_from_hash' do
      subject { instance.initialize_from_hash(h, bg) }

      it { skip }
    end

    describe '#blank?' do
      subject { instance.blank? }

      context 'when both foreground and background are set' do
        it { skip; subject.must_equal(false) }
      end

      context 'when either foreground and background are set' do
        it { skip; subject.must_equal(false) }
      end

      context 'when neither foreground and background are set' do
        it { subject.must_equal(true) }
      end
    end

  end # Style

end # Coloration
