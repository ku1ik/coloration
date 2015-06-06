require 'test_helper'

module Coloration

  module Writers

    class TestClass

      include AbstractWriter

    end

    describe JEditThemeWriter do

      let(:described) { Coloration::Writers::JEditThemeWriter }
      let(:instance)  { Coloration::Writers::TestClass.new }

      describe '#build_result' do
        subject { instance.build_result }

        it { skip }
      end

    end # JEditThemeWriter

  end # Writers

end # Coloration
