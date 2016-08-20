require 'worque/utils/command'
require 'worque/utils/business_day'
require 'date'

module Worque
  module Command
    module Todo
      class Action
        def initialize(options)
          @options = options
          validate_options!
        end

        def call
          Worque::Utils::Command.mkdir(options.path)

          notes_file_path = filename(date_for).tap do |f|
            Worque::Utils::Command.touch f
          end

          if options.append_task
            Worque::Utils::Command.append_text(notes_file_path, options.append_task)
          end

          notes_file_path
        end

        class << self
          def run(options)
            new(Worque::Command::Todo::Options.new(options)).call()
          end
        end

        private

        attr_reader :options

        def date_for
          case options.for.to_sym
          when :today
            Date.today
          when :yesterday
            Worque::Utils::BusinessDay.previous(Date.today, options.skip_weekend?)
          when :tomorrow
            Worque::Utils::BusinessDay.next(Date.today, options.skip_weekend?)
          end
        end

        def filename(date)
          "#{options.path}/notes-#{date}.md"
        end

        def validate_options!
          if options.path.to_s.empty?
            raise InvalidPath, 'Neither --path nor WORQUE_PATH is not set'
          end
        end
      end
    end
  end
end
