ENV['WORQUE_PATH'] = 'tmp/for/test'

require 'test_helper'
require 'worque'
require 'thor/runner'

describe Worque do
  describe 'todo' do
    before do
      $stdout = StringIO.new
    end

    it 'creates a notes for today' do
      date = Date.new(2016, 7, 14)
      Timecop.freeze(date) do
        ARGV.replace %w[todo]
        Worque::CLI.start
        assert_equal($stdout.string, "tmp/for/test/notes-2016-07-14.md\n")
      end
    end

    it 'creates a notes for yesterday' do
      date = Date.new(2016, 7, 14)
      Timecop.freeze(date) do
        ARGV.replace %w[todo --for yesterday]
        Worque::CLI.start
        assert_equal($stdout.string, "tmp/for/test/notes-2016-07-13.md\n")
      end
    end

    it 'creates a notes for last friday if today is Monday and skip weekend is set' do
      date = Date.new(2016, 7, 18)
      Timecop.freeze(date) do
        ARGV.replace %w[todo --for=yesterday]
        Worque::CLI.start
        assert_equal($stdout.string, "tmp/for/test/notes-2016-07-15.md\n")
      end
    end

    it 'creates a notes for sunday if today is Monday and NO skip weekend is set' do
      date = Date.new(2016, 7, 18)
      Timecop.freeze(date) do
        ARGV.replace %w[todo --for yesterday --no-skip-weekend]
        Worque::CLI.start
        assert_equal($stdout.string, "tmp/for/test/notes-2016-07-17.md\n")
      end
    end
  end
end
