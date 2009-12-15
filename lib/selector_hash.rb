module Coloration

  class SelectorHash < Hash
    def initialize(h={})
      h.keys.each do |key|
        self[key] = h[key]
      end
    end
    
#     def find_key(key)
#       to_check = []
#       elems = key.split(".")
#       elems.size.times do |i|
#         to_check << "(^|,\\s*)"+Regexp.escape(elems[0..i].join("."))+"(\\s*,|$)"
#       end
#       to_check << "^#{Regexp.escape(key)}$"
#       to_check.reverse!
#       #p to_check
#       to_check.each do |r|
#         regexp = Regexp.new(r)
#         newkey = @hash.keys.grep(regexp).first
#         puts "found key #{newkey} for #{key}" if newkey && $DEBUG
#         return newkey if newkey
#       end
#       puts "key #{key} not found" if $DEBUG
#       key
#     end

    def [](key)
      super(key.to_s)
#       key = find_key(key) if key.is_a?(String)
#       @hash[key]
    end

#     def method_missing(name, *args)
#       @hash.send(name, *args)
#     end
  end

end
