require 'test_helper'

module Coloration

  module Writers

    describe JEdit do

      let(:described) { Coloration::Writers::JEdit }
      let(:instance)  { described.new(input, converter, from, _name) }
      let(:input)     {}
      let(:converter) {}
      let(:from)      {}
      let(:_name)     {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }
        it { instance.instance_variable_get('@converter').must_equal(converter) }
        it { instance.instance_variable_get('@from').must_equal(from) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.translate' do
        subject { describe.translate }

        it { skip }
      end

    end # JEdit

  end # Writers

end # Coloration
