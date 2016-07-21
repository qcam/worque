require 'worque/utils/command'

module Worque
  module Command
    class Todo

      def initialize(options)
        @options = options
      end

      def call
        validate_options!

        Worque::Utils::Command.mkdir(options.path)

        file = case options.mode.to_sym
               when :today
                 filename(Date.today)
               when :yesterday
                 filename(Worque::BusinessDay.previous(Date.today))
               when :yesterday_hardcore
                 filename(Worque::BusinessDay.previous_continuous(Date.today))
               end
        Worque::Utils::Command.touch file
        return file
      end

      private

      attr_reader :options

      def validate_options!
        errors = options.validate

        raise errors.join(', ') if errors.size > 0
      end

      def filename(date)
        "#{options.path}/checklist-#{date}.md"
      end
    end
  end
end
