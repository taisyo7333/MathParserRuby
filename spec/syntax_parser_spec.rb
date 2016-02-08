require 'spec_helper'

RSpec.describe 'Syntax Parser Test' do
  before do
  end

  context 'Basic Test' do
    before do
      input = "1 + 2"
      lexer = TokenParser.new(input)
      @parser = SyntaxParser.new(lexer)
    end

    it 'Basic Test' do
      expect(@parser.next_token.content).to eq("1")
      expect(@parser.next_token.content).to eq("+")
      expect(@parser.next_token.content).to eq("2")
    end

    it 'Basic Test 2' do
      ast = @parser.expression      
      expect(ast.left.content).to eq("1")
      expect(ast.op.content).to eq("+")
      expect(ast.right.content).to eq("2")
    end
  end
end
