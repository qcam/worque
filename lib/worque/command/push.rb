require 'worque/utils/slack'
require 'worque/utils/business_day'

module Worque
  module Command
    class Push
      def initialize(options)
        @options = options
      end

      def call
        slack = Worque::Utils::Slack.new(options.token)
        slack.post(options.channel, report_file_content)
      end

      def self.run(options)
        require 'worque/command/push/options'

        Worque::Command::Push.new(
          Worque::Command::Push::Options.new(options)
        ).call()
      end

      private

      attr_reader :options

      def date_for
        case options.for.to_sym
        when :today
          Date.today
        when :yesterday
          Worque::Utils::BusinessDay.previous(Date.today, true)
        end
      end

      def report_file_content
        File.open(report_file_path).read
      end

      def report_file_path
        "#{ ENV['WORQUE_PATH'] }/notes-#{date_for}.md"
      end
    end
  end
end

