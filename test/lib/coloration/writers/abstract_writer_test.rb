require 'test_helper'

module Coloration

  module Writers

    class TestClass

      include AbstractWriter

    end

    describe AbstractWriter do

      let(:described) { Coloration::Writers::AbstractWriter }
      let(:instance)  { Coloration::Writers::TestClass.new }

      describe '#add_line' do
        let(:line) { 'some parsed line' }

        subject { instance.add_line(line) }

        it { subject.must_be_instance_of(Array) }

        it 'adds a line' do
          subject.must_equal(['some parsed line'])
        end
      end

    end # AbstractWriter

  end # Writers

end # Coloration
