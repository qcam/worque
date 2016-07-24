require 'test_helper'

describe Worque::Command::Todo::Options do
  describe '#initialize' do
    it 'accepts mass assignments' do
      opts = Worque::Command::Todo::Options.new(path: 'tmp', skip_weekend: true, for: 'tomorrow')

      assert_equal 'tmp', opts.path
      assert opts.skip_weekend?
      assert_equal 'tomorrow', opts.for
    end
  end
end
