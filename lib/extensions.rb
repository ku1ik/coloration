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
end
