class Object
  def blank?
    false
  end

  def try(*args)
    send(*args) if respond_to?(args.first)
  end
end

class String
  def blank?
    self.strip == ""
  end
end

class NilClass
  def blank?
    true
  end
end

class FalseClass
  def to_i
    0
  end
end

class TrueClass
  def to_i
    1
  end
end
