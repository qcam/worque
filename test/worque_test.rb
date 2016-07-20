require 'test_helper'
require 'date'
require 'worque/business_day'

class WorqueTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Worque::VERSION
  end

  def test_it_does_something_useful
    assert true
  end

  def test_that_business_day_previous_continuous_dont_skip_sunday
    sunday = Worque::BusinessDay.previous_continuous(Date.new(2016,7,18)) # 07/18/2016 is Monday
    assert sunday.wday == 0
  end

  def test_that_business_day_previous_skip_sunday
    friday = Worque::BusinessDay.previous(Date.new(2016,7,18)) # 07/18/2016 is Monday
    assert friday.wday == 5
  end
end
