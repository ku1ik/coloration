class Object
  def blank?
    false
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
  
  def to_i
    0
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
