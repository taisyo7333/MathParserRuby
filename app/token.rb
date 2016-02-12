class TokenError < RuntimeError 
end

class Token
  attr_reader :content
  attr_reader :type

  def initialize(c)
    @content = c
    @type = map_type(c)
  end
  #
  def <=>(other)
    return  0 if @type == other.type && @content == other.concent
    return  1 if @type < other.type
    return -1 
  end

  def to_a 
    return [@type,@content]
  end

  def to_rpn(ar)
    ar << to_a
    return ar
  end

  # Class method
  class << self
    def paren?(c)
      return true if( c == "(" )
      return true if( c == ")" )
      false
    end
    def operator?(c)
      return true if( c == "-" )
      return true if( c == "+" )
      return true if( c == "*" )
      return true if( c == "/" )
      return false
    end
    def num?(c)
      return !!(c =~ /[0-9]/)
    end   
  end

  # Get type code from input string.
  def map_type(input)
    case input
    when '(' ; :L_PAREN
    when ')' ; :R_PAREN
    when '+' ; :OP_PLUS
    when '-' ; :OP_MINUS
    when '*' ; :OP_MULTI
    when '/' ; :OP_DIV
    when /-?\d+\.\d+/ ; :REAL
    when /-?\d+/ ; :INT
    else
      raise TokenError.exception("#{input} is not parsed as token.")
    end
  end
end
