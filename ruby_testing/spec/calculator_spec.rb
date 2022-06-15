require './lib/calculator'

describe Calculator do
  describe '#add' do
    it 'Returns the sum of two numbers' do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it 'returns the sum of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe '#multiply' do
    it 'Multiplies two numbers togther' do
      calculator = Calculator.new
      expect(calculator.multiply(7, 7)).to eql(49)
    end
  end
end