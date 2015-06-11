class Object
  # @return [Boolean]
  def blank?
    false
  end

  # @param args []
  # @return [void]
  # @todo
  def try(*args)
    send(*args) if respond_to?(args.first)
  end
end

class String
  # @return [Boolean]
  def blank?
    self.strip == ""
  end
end

class NilClass
  # @return [Boolean]
  def blank?
    true
  end
end

class FalseClass
  # @return [Fixnum]
  def to_i
    0
  end
end

class TrueClass
  # @return [Fixnum]
  def to_i
    1
  end
end
