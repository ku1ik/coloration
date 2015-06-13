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

  end # Style

end # Coloration
