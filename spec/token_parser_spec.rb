require 'spec_helper'

RSpec.describe 'Token Parser basic test' do

  before do
  end

  context 'Only number test' do
    before do
      input = "123"
      @lexer = TokenParser.new(input)
    end

    it 'empty?' do
      expect(@lexer.empty?).to eq false
    end

    it 'Only number' do
      expect(@lexer.next_token.content).to eq("123")
      expect(@lexer.next_token).to eq nil
      expect( @lexer.done?).to eq true
    end
  end
  context 'Only real number' do
    before do
      @lexer = TokenParser.new("98.01")
    end

    it 'next' do
      expect(@lexer.next_token.content).to eq("98.01")      
    end
  end

  context 'Only operator +' do
    before do
      @lexer = TokenParser.new("+")
    end

    it 'Next' do
      expect(@lexer.next_token.content).to eq("+")
    end
  end

  context '39 + 665 * 9.0 / 1.5' do
    before do
      input = "39 + 665 * 9.0 / 1.5"
      @lexer = TokenParser.new(input)
    end
    it 'next test' do
      expect(@lexer.next_token.content).to eq("39")
      expect(@lexer.next_token.content).to eq("+")
      expect(@lexer.next_token.content).to eq("665")
      expect(@lexer.next_token.content).to eq("*")
      expect(@lexer.next_token.content).to eq("9.0")
      expect(@lexer.next_token.content).to eq("/")
      expect(@lexer.next_token.content).to eq("1.5")
    end
  end
end
