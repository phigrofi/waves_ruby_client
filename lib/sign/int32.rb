# frozen_string_literal: true

# simulate 32 bit integer with overflow
class Int32
  attr_accessor :val
  def initialize(val)
    self.val = if val.is_a?(Int32)
                 val.val
               else
                 val
               end
  end

  def ==(other)
    to_i == if other.is_a?(Int32)
              other.to_i
            else
              other
            end
  end

  def self.force_overflow_signed(i)
    force_overflow_unsigned(i + 2**31) - 2**31
  end

  def self.force_overflow_unsigned(i)
    i % 2**32 # or equivalently: i & 0xffffffff
  end

  def r_shift_pos(other)
    other_val = other.is_a?(Int32) ? other.val : other
    Int32.new(self.class.force_overflow_unsigned(val) >> other_val)
  end

  def to_i
    self.class.force_overflow_signed(val)
  end

  def dup
    Int32.new(val)
  end

  ['|', '^', '+', '-', '&', '*'].each do |op|
    define_method op do |other|
      if other.is_a?(Int32)
        Int32.new(to_i.send(op, other.to_i))
      else
        super(other)
      end
    end
  end

  private

  def respond_to_missing?(meth, _include_private = false)
    val.respond_to?(meth)
  end

  def method_missing(meth, *args, &block)
    return super unless respond_to_missing?(meth)
    Int32.new(self.class.force_overflow_signed(val.send(meth, *args, &block)))
  end
end
