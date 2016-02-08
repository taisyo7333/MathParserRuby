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

  def expression 
    $stderr.puts "++++expression++++"
    tree_left = term()
    ast = Ast.new()
    begin
      # 演算子を期待
      token = next_token()
      return tree_left if token.nil?
      $stderr.puts "[OP]:#{token.type}:#{token.content}"
      while( token.type == :OP_PLUS || token.type == :OP_MINUS )
        ast.left = tree_left
        ast.op = token

        tree_right = term()
        ast.right = tree_right
        
        # 演算子を期待
        token = next_token()
        return ast if token.nil?
        if  (token.type == :OP_PLUS || token.type == :OP_MINUS) then
          tree_left = ast
          
          ast_crr = ast;
          ast = Ast.new()
        end
      end
      # TODO
      raise SyntaxParserError.exception("構文エラー#001")
    rescue
    ensure
    end
    $stderr.puts "---expression---"
    return ast
  end

  def term
    factor()
  end
  
  def factor
    $stderr.puts "++++factor++++"
    token = next_token()
    if token.type == :L_PAREN  then
      $stderr.puts "("
      tree = expression()

      $stderr.puts ")"
# 先読みしているので不要      
#      token = next_token()
      token = @look_ahead
      if token.type != :R_PAREN then
        raise SyntaxParserError.exception('()の対応に問題があります。')
      end
      $stderr.puts "[[factor]] #{tree.op.content},#{tree.left.content},#{tree.right.content}"
      return tree
    elsif token.type == :REAL || token.type == :INT  then
      $stderr.puts "<factor> NUM: #{token.type}:#{token.content}"
      return token
    else

      s = "解釈できないトークン:#{token.content} : #{token.type}"
      raise SyntaxParserError.exception(s)
    end
  end
end



