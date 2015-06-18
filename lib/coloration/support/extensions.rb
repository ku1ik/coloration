# Provides enhancements to core Ruby classes.
# @todo Remove these as soon as possible.
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

# Provides enhancements to core Ruby classes.
# @todo Remove these as soon as possible.
class String
  # @return [Boolean]
  def blank?
    self.strip == ""
  end
end

# Provides enhancements to core Ruby classes.
# @todo Remove these as soon as possible.
class NilClass
  # @return [Boolean]
  def blank?
    true
  end
end

# Provides enhancements to core Ruby classes.
# @todo Remove these as soon as possible.
class FalseClass
  # @return [Fixnum]
  def to_i
    0
  end
end

# Provides enhancements to core Ruby classes.
# @todo Remove these as soon as possible.
class TrueClass
  # @return [Fixnum]
  def to_i
    1
  end
end
