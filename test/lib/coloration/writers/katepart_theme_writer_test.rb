require 'test_helper'

module Coloration

  module Writers

    class TestClass

      include AbstractWriter

    end

    describe KatePartThemeWriter do

      let(:described) { Coloration::Writers::KatePartThemeWriter }
      let(:instance)  { Coloration::Writers::TestClass.new }

      describe '#build_result' do
        subject { instance.build_result }

        it { skip }
      end

    end # KatePartThemeWriter

  end # Writers

end # Coloration
