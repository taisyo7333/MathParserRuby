# encoding: UTF-8
require_relative 'token'
require_relative 'token_parser'

class SyntaxParserError < RuntimeError
end

class Ast
  attr_accessor :left
  attr_accessor :op 
  attr_accessor :right

  def initialize
    @left  = nil
    @right = nil
    @op    = nil
  end

  def to_s
    if @op.nil?
      return @left.to_s
    elsif @op.right?
    end
  end

  def to_a
    [@op.to_s , @left.to_s , @right.to_s]
  end

end

# 字句解析器
# 下記のPEGを実装する
# exp    := term(('+'|'-')term)*
# term   := factor(('*'|'/')factor)*
# factor := '('exp')' | RealNumber | Integer

class SyntaxParser
  def initialize token_parser
    @token_parser = token_parser
    @look_ahead = nil
  end

  def next_token
    @look_ahead = @token_parser.next_token
    @look_ahead
  end

  def parse
    next_token() # 先読み
    expression()
  end

  def expression 
    tree_left = term()
    ast = Ast.new()

    # 演算子を期待
    token = @look_ahead
    return tree_left if token.nil?
    while( token.type == :OP_PLUS || token.type == :OP_MINUS )
      next_token() # 先読み

      ast.left = tree_left
      ast.op = token
      
      tree_right = term()
      ast.right = tree_right
      
      # 演算子を期待
      token = @look_ahead
      return ast if token.nil?
      if  (token.type == :OP_PLUS || token.type == :OP_MINUS) then
        tree_left = ast
        
        ast_crr = ast;
        ast = Ast.new()
      end

    end
    return ast
  end

  def term
    factor()
  end
  
  def factor
    token = @look_ahead
    if token.type == :L_PAREN  then
      next_token() # 先読み

      tree = expression()
      token = @look_ahead
      if token.type != :R_PAREN then
        raise SyntaxParserError.exception('()の対応に問題があります。')
      end
      next_token() # 先読み
      return tree
    elsif token.type == :REAL || token.type == :INT  then
      next_token() # 先読み
      return token
    else

      s = "解釈できないトークン:#{token.content} : #{token.type}"
      raise SyntaxParserError.exception(s)
    end
  end
end



