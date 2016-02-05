# -*- coding: utf-8 -*-
require_relative 'token'

class TokenParserError < RuntimeError
end

# 字句解析器
class TokenParser
  attr_reader :input

  # Constructor
  def initialize(input)
    @input = input
    @index = 0
    @look_ahead = nil

    exec_look_ahead()    # 先読み
  end

  # Is it empty ?
  def empty?
    @input.empty?
  end
  # Have you already done ?
  def done?
    return @input.size <= @index
  end
  # 先読み
  def exec_look_ahead
    @look_ahead = step()
  end
  # 1文字ずつ読み進める
  # 空白は無視する
  # something : 次の位置文字を取得する
  # nil       : ない場合(末尾到達時)
  def step
    return nil if @input.nil? || @input.empty?
    return nil if @input.size <= @index
    # 空白を無視する
    while ( @index < @input.size && @input[@index] == ' ' ) do
      @index += 1
    end    
    
    return nil if @input.size <= @index

    @index += 1
    return @input[@index-1]
  end

  # 次のTokenを取り出す
  def next_token
    return nil if @look_ahead.nil?

    if Token.paren?(@look_ahead) || Token.operator?(@look_ahead) then
      ope = Token.new(@look_ahead)
      exec_look_ahead() # 先読み
      return ope
    elsif Token.num?(@look_ahead) then
      # 整数、実数であるかチェックする
      num = @look_ahead

      exec_look_ahead() # 先読み
      while Token.num?(@look_ahead) do
        num += @look_ahead
        exec_look_ahead() # 先読み
      end

      # Case in real number
      if @look_ahead == '.' then
        num += @look_ahead
        exec_look_ahead() # 先読み
        
        raise TokenParserError.exception('Failure to parse real number.') unless Token.num?(@look_ahead)
        
        num += @look_ahead
        exec_look_ahead() # 先読み
        
        while Token.num?(@look_ahead) do
          num += @look_ahead
          exec_look_ahead() # 先読み
        end
      end

      # REAL NUMBER or INTEGER
      return Token.new(num)
    else
      # いずれにも該当しない
      raise TokenParserError.exception('Detect invalid character for TokenParser')
    end

  end

  # 非公開
  private :step , :exec_look_ahead
end
