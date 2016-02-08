require 'spec_helper'

RSpec.describe 'Syntax Parser Test' do
  before do
  end

  context 'Basic Test 1 + 2' do
    before do
      input = "1 + 2"
      lexer = TokenParser.new(input)
      @parser = SyntaxParser.new(lexer)
    end

    it 'next_token' do
      expect(@parser.next_token.content).to eq("1")
      expect(@parser.next_token.content).to eq("+")
      expect(@parser.next_token.content).to eq("2")
    end

    it 'Make abstract syntax tree' do
      root = @parser.expression      
      ast = root.left
      expect(ast.left.content).to eq("1")
      expect(ast.op.content).to eq("+")
      expect(ast.right.content).to eq("2")
    end
  end

  context 'Basic Test 1 + 2 + 3' do
    before do
      input = "1 + 2 + 3"
      lexer = TokenParser.new(input)
      @parser = SyntaxParser.new(lexer)
    end

    it 'next_token' do
      expect(@parser.next_token.content).to eq("1")
      expect(@parser.next_token.content).to eq("+")
      expect(@parser.next_token.content).to eq("2")
      expect(@parser.next_token.content).to eq("+")
      expect(@parser.next_token.content).to eq("3")      
    end

    it 'Make abstract syntax tree' do
      root = @parser.expression      
      ast = root.left
      # ()
      expect(ast.op.content).to eq("+")
      expect(ast.right.content).to eq("3")

      # (+ 1 2 )
      ast_1p2 = ast.left
      expect(ast_1p2.left.content).to eq("1")
      expect(ast_1p2.op.content).to eq("+")
      expect(ast_1p2.right.content).to eq("2")
    end
  end
end
