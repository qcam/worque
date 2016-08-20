require 'thor'
require 'worque/command/todo/action'
require 'worque/command/todo/options'
require 'worque/command/push/action'
require 'worque/command/push/options'

module Worque
  class CLI < ::Thor
    package_name 'Worque CLI'

    desc 'todo', 'Make a todo'

    method_option :for, type: :string, enum: ['today', 'yesterday', 'tomorrow'], default: 'today'
    method_option :skip_weekend, type: :boolean, default: true
    method_option :path, type: :string, default: ENV['WORQUE_PATH']
    method_option :append_task, type: :string

    def todo
      begin
        result = Worque::Command::Todo::Action.run(options)
      rescue InvalidPath => e
        abort e.message
      end

      $stdout.puts result
    end

    desc 'push', 'Push your notes to Slack channel'

    method_option :for, type: :string, enum: ['today', 'yesterday', 'tomorrow'], default: 'today'
    method_option :channel, required: true, type: :string, desc: 'Can be channel, private group ID or name. E.g. #daily-report'

    def push
      $stdout.puts Worque::Command::Push::Action.run(options)
    end
  end
end
