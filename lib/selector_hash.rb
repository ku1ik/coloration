module Coloration

  class SelectorHash < Hash
    def initialize(h={})
      h.keys.each do |key|
        self[key] = h[key]
      end
    end

    def [](key, deep=true)
      return nil if key.blank?
      key = key.to_s
#       puts "trying #{key}"
      value = super(key)
      if value
        value
      elsif deep
        self[key.split(".")[0..-2].join(".")]
      end
    end
  end

end
