module Worque
  module Command
    class Push::Options
      attr_reader :channel
      attr_reader :token
      attr_reader :for

      def initialize(options)
        @channel = options[:channel]
        @for = options[:for]
        @token = options[:token]
      end
    end
  end
end
