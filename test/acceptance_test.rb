ENV['WORQUE_PATH'] = 'tmp/for/test'

require 'test_helper'
require 'worque'
require 'thor/runner'
require 'webmock/minitest'
require 'json'

describe Worque do
  describe 'todo' do
    before do
      $stdout = StringIO.new
    end
    
    after do
      system "rm -rf tmp/*"
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

  describe 'push' do
    before do
      @path = ENV['WORQUE_PATH']
      @today = Date.new(2016, 7, 14)

      Timecop.freeze(@today) do
        Worque::Command::Todo.run(path: @path, for: 'today')
      end

      $stdout = StringIO.new
      $stderr = StringIO.new
    end

    it 'raises error if no channel specified' do
      date = Date.new(2016, 7, 14)
      Timecop.freeze(date) do
        ARGV.replace %w[push]
        Worque::CLI.start
        assert_equal($stderr.string, "No value provided for required options '--channel'\n")
      end
    end

    describe 'channel are specified' do
      before do
        stubbed_result = {
          "ok"=>true,
          "channel"=>"secret",
          "ts"=>"1469116417.000010",
          "message" => {
            "type"=>"message",
            "user"=>"U02G4HZSH",
            "text"=>"Hello World from the other side",
            "bot_id"=>"secret",
            "ts"=>"1469116417.000010"
          }
        }.to_json

        stub_request(:any, 'https://slack.com/api/chat.postMessage')
          .to_return(body: stubbed_result)
      end

      it 'pushes the notes today to Slack channel' do
        date = Date.new(2016, 7, 14)
        Timecop.freeze(date) do
          ARGV.replace %w[push --channel=hello]
          Worque::CLI.start
          result = JSON.parse($stdout.string.strip)
          assert(result['ok'])
        end
      end
    end
  end
end
