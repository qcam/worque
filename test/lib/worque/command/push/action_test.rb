require 'test_helper'
require 'webmock/minitest'

describe Worque::Command::Push::Action do
  let(:action) { Worque::Command::Push::Action }

  before do
    # Clean up tmp directory
    options = { path: 'tmp/hello/world', for: 'today' }
    ENV['SLACK_API_TOKEN'] = 'test-token'

    Worque::Command::Todo::Action.run(options)

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

    stub_request(:post, "http://slack.com:443/api/chat.postMessage").
      to_return(status: 200, body: stubbed_result, headers: {})

    stub_request(:post, "https://slack.com/api/chat.postMessage").
      to_return(status: 200, body: stubbed_result, headers: {})
  end

  after { system('rm -rf tmp/*') }

  describe '#call' do
    it 'pushes the file to Slack' do
      result = action.run(path: 'tmp/hello/world/', channel: 'test', for: 'today')

      assert(result['ok'])
    end
  end
end
