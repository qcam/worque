require 'json'
require 'net/http'

module Worque
  module Utils
    class Slack
      def initialize(token)
        @token = token
      end

      def post(channel, message)
        JSON.parse(post_form(channel, message).body)
      end

      private

      def post_form(channel, message)
        uri = URI.parse('https://slack.com/api/chat.postMessage')
        Net::HTTP.post_form(uri, as_user: true, channel: channel, token: @token, text: message)
      end
    end
  end
end
