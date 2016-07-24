require 'test_helper'
require 'webmock/minitest'
require 'worque/utils/slack'

describe Worque::Utils::Slack do
  describe '#post' do
    before do
      stubbed_result = {
        "ok"=>true,
        "channel"=>"secret",
        "ts"=>"1469116417.000010",
        "message" => {
          "type"=>"message",
          "user"=>"secret",
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

    it 'posts message to slack' do
      token = 'just-a-token'
      result = Worque::Utils::Slack
        .new(token)
        .post('#cam-test', "Hello World from Cam's computer")

      assert result['ok']
    end
  end
end
