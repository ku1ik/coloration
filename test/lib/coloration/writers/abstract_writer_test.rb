require 'test_helper'

module Coloration

  module Writers

    class TestClass

      include AbstractWriter

    end

    describe AbstractWriter do

      let(:described) { Coloration::Writers::AbstractWriter }
      let(:instance)  { Coloration::Writers::TestClass.new }

      describe '#comment_message' do
        subject { instance.comment_message }

        it { skip; subject.must_be_instance_of(String) }
      end

      describe '#format_item' do
        let(:_name) {}
        let(:style) {}

        subject { instance.format_item(_name, style) }

        it { skip }
      end

      describe '#store' do
        let(:line) { 'some parsed line' }

        subject { instance.store(line) }

        it { subject.must_be_instance_of(Array) }

        it 'adds a line' do
          subject.must_equal(['some parsed line'])
        end
      end

      describe '#retrieve' do
        subject { instance.retrieve }

        it { skip }
      end

    end # AbstractWriter

  end # Writers

end # Coloration
