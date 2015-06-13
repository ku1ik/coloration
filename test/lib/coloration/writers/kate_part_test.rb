require 'test_helper'

module Coloration

  module Writers

    describe KatePart do

      let(:described) { Coloration::Writers::KatePart }
      let(:instance)  { described.new(input, reader) }
      let(:input)     {}
      let(:reader)    {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }
        it { instance.instance_variable_get('@reader').must_equal(reader) }
      end

      describe '.translate' do
        subject { described.translate }

        it { skip }
      end

    end # KatePart

  end # Writers

end # Coloration
