module Color
  COLOR_TOOLS_VERSION = '1.3.0'

  class RGB; end
  class CMYK; end
  class GrayScale; end
  class YIQ; end
end

require 'coloration/color/rgb'
require 'coloration/color/color_rgba.rb'
require 'coloration/color/cmyk'
require 'coloration/color/grayscale'
require 'coloration/color/hsl'
require 'coloration/color/yiq'
require 'coloration/color/rgb/metallic'
require 'coloration/color/css'
require 'coloration/color/palette/gimp'
require 'coloration/color/palette/monocontrast'

module Color
  def self.const_missing(name) #:nodoc:
    if Color::RGB.const_defined?(name)
      warn "These colour constants have been deprecated. Use Color::RGB::#{name} instead."
      Color::RGB::constants.each do |const|
        next if const == "PDF_FORMAT_STR"
        next if const == "Metallic"
        const_set(const, Color::RGB.const_get(const))
      end
      class << Color; remove_method :const_missing; end
      Color.const_get(name)
    else
      super
    end
  end
end
