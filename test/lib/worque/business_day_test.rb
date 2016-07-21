require 'test_helper'
require 'worque/business_day'
require 'date'

describe Worque::BusinessDay do
  describe '.previous' do
    it 'returns the previous day' do
      thursday = Date.new(2016, 7, 14)
      assert Worque::BusinessDay.previous(thursday).wday == 3
    end

    it 'skips weekend by default' do
      monday = Date.new(2016, 7, 18)
      assert Worque::BusinessDay.previous(monday).wday == 5
    end

    it 'does not skip weekend if skip_weekend is set' do
      monday = Date.new(2016, 7, 18)
      assert Worque::BusinessDay.previous(monday, false).wday == 0
    end
  end
end

