require 'test_helper'

describe Worque::Command::Push::Options do
  describe '#initialize' do
    it 'accepts mass assignments' do
      opts = Worque::Command::Push::Options.new(channel: 'test', for: 'tomorrow')

      assert_equal opts.token, ENV['SLACK_API_TOKEN']
      assert_equal opts.channel, 'test'
      assert_equal opts.for, 'tomorrow'
    end
  end
end
