# encoding: UTF-8

describe 'NumberHelper' do

  include NumberHelper

  describe '#number_to_currency' do

    context 'using default values' do

      it "correctly formats an integer" do
        expect(number_to_currency(1)).to(eq("$1.00"))
      end

      it "correctly formats a float" do
        expect(number_to_currency(1.0)).to(eq("$1.00"))
      end

      it "correctly formats a string" do
        expect(number_to_currency("1")).to(eq("$1.00"))
      end

      it "uses delimiters for very large numbers" do
        expect(number_to_currency(9999999)).to(eq("$9,999,999.00"))
      end

      it "does not have delimiters for small numbers" do
        expect(number_to_currency(999)).to(eq("$999.00"))
      end

    end

    context 'using custom options' do

      it 'allows changing the :unit' do
        expect(number_to_currency(1, {unit: '£'})).to(eq("£1.00"))
      end

      it 'allows changing the :precision' do
        expect(number_to_currency(1, {precision: 5})).to(eq("$1.00000"))
      end

      it 'omits the separator if :precision is 0' do
        expect(number_to_currency(1, {precision: 0})).to(eq("$1"))
      end

      it 'allows changing the :delimiter'

      it 'allows changing the :separator'

      it 'correctly formats using multiple options'

    end

  end

end
