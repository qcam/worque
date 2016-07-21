require 'test_helper'
require 'webmock/minitest'

describe Worque::Command::Push do
  before do
    # Clean up tmp directory
    options = { path: 'tmp/hello/word', for: 'today' }
    Worque::Command::Todo.run(options)
    ENV['WORQUE_PATH'] = options[:path]
    ENV['SLACK_API_TOKEN'] = 'test-token'

    # Stub Slack API call
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

  after { system('rm -rf tmp/*') }

  describe '#call' do
    it 'pushes the file to Slack' do
      result = Worque::Command::Push.run(channel: 'test', for: 'today')

      assert(result['ok'])
    end
  end
end
