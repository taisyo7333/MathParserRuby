require 'spec_helper'

RSpec.describe 'Token' do
  context 'Select Token code [Success]' do
    it 'Left parenthesis (' do
      t = Token.new('(')
      expect(t.type).to eq :L_PAREN
      expect(t.content).to eq '('
    end

    it 'Right parenthesis )' do
      t = Token.new(')')
      expect(t.type).to eq :R_PAREN
      expect(t.content).to eq ')'
    end

    it 'Operator +' do
      t = Token.new('+')
      expect(t.type).to eq :OP_PLUS
      expect(t.content).to eq '+'
    end

    it 'Operator -' do
      t = Token.new('-')
      expect(t.type).to eq :OP_MINUS
      expect(t.content).to eq '-'
    end

    it 'Operator *' do
      t = Token.new('*')
      expect(t.type).to eq :OP_MULTI
      expect(t.content).to eq '*'
    end

    it 'Operator /' do
      t = Token.new('/')
      expect(t.type).to eq :OP_DIV
      expect(t.content).to eq '/'
    end

    it 'INT PLUS' do
      t = Token.new('245')
      expect(t.type).to eq :INT
      expect(t.content).to eq '245'
    end


    it 'INT MINUS' do
      t = Token.new('-123')
      expect(t.type).to eq :INT
      expect(t.content).to eq '-123'
    end

    it 'REAL PLUS' do
      t = Token.new('10.23')
      expect(t.type).to eq :REAL
      expect(t.content).to eq '10.23'
    end

    it 'REAL MINUS' do
      t = Token.new('-10.23')
      expect(t.type).to eq :REAL
      expect(t.content).to eq '-10.23'
    end
  end

  context 'Select Token code [Exception]' do
    it 'Raise Exception Cain in invalid character' do
      expect{ Token.new('@') }.to raise_error TokenError
    end

    it 'Raise Exception Case in empty ' do
      expect{ Token.new('') }.to raise_error TokenError
    end

    it 'Raise Exception Case in nil' do
      expect{ Token.new(nil) }.to raise_error TokenError
    end
  end
end
