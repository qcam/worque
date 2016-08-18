require 'test_helper'
require 'date'

describe Worque::Utils::BusinessDay do
  before do
    @helper = Worque::Utils::BusinessDay
  end

  describe '.next' do
    it 'returns the next day' do
      thursday = Date.new(2016, 7, 14)
      assert_equal 5, @helper.next(thursday).wday
    end

    it 'skips weekend by default' do
      friday = Date.new(2016, 7, 15)
      assert_equal 1, @helper.next(friday).wday
    end

    it 'does not skip weekend if skip_weekend is set' do
      friday = Date.new(2016, 7, 15)
      assert_equal 6, @helper.next(friday, false).wday
    end
  end
  
  describe '.previous' do
    it 'returns the previous day' do
      thursday = Date.new(2016, 7, 14)
      assert_equal 3, @helper.previous(thursday).wday
    end

    it 'skips weekend by default' do
      monday = Date.new(2016, 7, 18)
      assert_equal 5, @helper.previous(monday).wday
    end

    it 'does not skip weekend if skip_weekend is set' do
      monday = Date.new(2016, 7, 18)
      assert_equal 0, @helper.previous(monday, false).wday
    end
  end
end

