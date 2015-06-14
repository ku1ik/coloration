require 'forwardable'
require 'logger'
require 'time'

require 'plist'
require 'textpow'

require 'coloration/support/extensions'
require 'coloration/support/items_lookup'
require 'coloration/support/log'
require 'coloration/support/normalize'
require 'coloration/support/style'
require 'coloration/support/color/yiq'
require 'coloration/support/color/rgb'
require 'coloration/support/color/rgba'

require 'coloration/writers/abstract_writer'
require 'coloration/writers/jedit'
require 'coloration/writers/kate_part'
require 'coloration/writers/vim'

require 'coloration/readers/text_mate'

require 'coloration/converters/text_mate/jedit'
require 'coloration/converters/text_mate/kate_part'
require 'coloration/converters/text_mate/vim'

require 'coloration/cli_parser'
require 'coloration/parser'
require 'coloration/version'

module Coloration

  EXCEPTIONS = %w(
    InvalidThemeError
    NoConverterError
    NoDestinationError
    NoReaderError
    NoSourceError
    NoWriterError
  )
  EXCEPTIONS.each { |e| const_set(e, Class.new(StandardError)) }

end
