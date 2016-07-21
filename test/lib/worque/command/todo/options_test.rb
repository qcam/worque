require 'test_helper'

describe Worque::Command::Todo::Options do
  describe '#initialize' do
    it 'accepts mass assignments' do
      opts = Worque::Command::Todo::Options.new(path: 'tmp', skip_weekend: true, for: 'tomorrow')

      assert opts.path == 'tmp'
      assert opts.skip_weekend?
      assert opts.for == 'tomorrow'
    end
  end
end
