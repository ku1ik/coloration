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

class Color::RGBA < Color::RGB
  def self.from_html(col, bg)
    if col.size > 7 # we have color with alpha channel
      alpha = (100 * ((col[-2..-1]).to_i(16) / 255.0)).to_i
      color = super(col[0..-3])
      color.mix_with(bg, alpha)
    else
      super(col)
    end
  end
end

