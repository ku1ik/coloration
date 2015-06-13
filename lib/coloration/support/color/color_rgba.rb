class Color::RGBA < Color::RGB

  # @param col [String] e.g. '#1a1a1a'
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
