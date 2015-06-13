require 'test_helper'

module Coloration

  describe VERSION do
    it { Coloration::VERSION.must_be_instance_of(String) }
  end

end # Coloration
