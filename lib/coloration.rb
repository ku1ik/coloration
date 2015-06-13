require 'forwardable'
require 'logger'
require 'time'

require 'plist'
require 'textpow'

require 'coloration/support/all'

require 'coloration/color/all'
require 'coloration/writers/all'
require 'coloration/readers/all'
require 'coloration/converters/all'
require 'coloration/all'

module Coloration

  EXCEPTIONS = %w(
    NoSourceError
    NoDestinationError
    NoReaderError
    NoWriterError
    InvalidThemeError
  )
  EXCEPTIONS.each { |e| const_set(e, Class.new(StandardError)) }

end
