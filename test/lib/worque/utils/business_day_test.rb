require 'test_helper'
require 'date'

describe Worque::Utils::BusinessDay do
  before do
    @helper = Worque::Utils::BusinessDay
  end

  describe '.previous' do
    it 'returns the previous day' do
      thursday = Date.new(2016, 7, 14)
      assert_equal @helper.previous(thursday).wday, 3
    end

    it 'skips weekend by default' do
      monday = Date.new(2016, 7, 18)
      assert_equal @helper.previous(monday).wday, 5
    end

    it 'does not skip weekend if skip_weekend is set' do
      monday = Date.new(2016, 7, 18)
      assert_equal @helper.previous(monday, false).wday, 0
    end
  end
end

