require 'test_helper'

module Coloration

  module Readers

    describe ItemsLookup do

      let(:described) { Coloration::Readers::ItemsLookup }
      let(:instance)  { described.new(items) }
      let(:items)     {}

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@items').must_equal(items) }
      end

      describe '#[]' do
        let(:keys) {}

        subject { instance.[](keys) }

        it { skip }
      end

    end # ItemLookup

  end # Readers

end # Coloration
