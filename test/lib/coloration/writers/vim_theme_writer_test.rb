require 'test_helper'

module Coloration

  module Writers

    class TestClass

      include AbstractWriter

    end

    describe VimThemeWriter do

      let(:described) { Coloration::Writers::VimThemeWriter }
      let(:instance)  { Coloration::Writers::TestClass.new }

      describe '#build_result' do
        subject { instance.build_result }

        it { skip }
      end

    end # VimThemeWriter

  end # Writers

end # Coloration
