require 'test_helper'

module Coloration

  module Writers

    describe Vim do

      let(:described) { Coloration::Writers::Vim }
      let(:instance)  { described.new(input, converter, from, _name, ui) }
      let(:input)     {}
      let(:converter) {}
      let(:from)      {}
      let(:_name)     {}
      let(:ui)        {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }
        it { instance.instance_variable_get('@converter').must_equal(converter) }
        it { instance.instance_variable_get('@from').must_equal(from) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@ui').must_equal(ui) }
      end

      describe '.translate' do
        subject { described.translate }

        it { skip }
      end

    end # Vim

  end # Writers

end # Coloration
