require 'test_helper'

describe Worque::Command::Push::Options do
  describe '#initialize' do
    it 'accepts mass assignments' do
      opts = Worque::Command::Push::Options.new(channel: 'test', for: 'tomorrow', token: 'secret')

      assert_equal 'secret', opts.token
      assert_equal 'test', opts.channel
      assert_equal 'tomorrow', opts.for
    end
  end
end
