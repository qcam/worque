module Worque
  module Command
    class Push::Options
      attr_reader :channel
      attr_reader :token
      attr_reader :for
      attr_reader :path

      def initialize(options)
        @channel = options[:channel]
        @path = options[:path]
        @for = options[:for]
        @token = options[:token]
      end
    end
  end
end
