require 'worque/utils/command'
require 'worque/utils/business_day'
require 'date'

module Worque
  module Command
    class Todo
      def initialize(options)
        @options = options
      end

      def call
        Worque::Utils::Command.mkdir(options.path)

        notes_file_path = filename(date_for)
        notes_file_path.tap do |f|
          Worque::Utils::Command.touch f
        end

        if options.append_task
          Worque::Utils::Command.append_text(notes_file_path, options.append_task)
        end

        notes_file_path
      end

      def self.run(options)
        Worque::Command::Todo.new(
          Worque::Command::Todo::Options.new(options)
        ).call()
      end

      private

      attr_reader :options

      def date_for
        case options.for.to_sym
        when :today
          Date.today
        when :yesterday
          Worque::Utils::BusinessDay.previous(Date.today, options.skip_weekend?)
        end
      end

      def filename(date)
        "#{options.path}/notes-#{date}.md"
      end
    end
  end
end
