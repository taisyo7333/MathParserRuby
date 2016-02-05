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
