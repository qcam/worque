require 'thor'
require 'worque/command/todo'
require 'worque/command/todo/options'

module Worque
  class CLI < ::Thor
    desc 'todo', 'Make a todo'

    method_option :for, force: false, type: :string, enum: ['today', 'yesterday'], default: 'today'
    method_option :skip_weekend, force: false, type: :boolean, default: true
    method_option :path, force: false, type: :string, default: ENV['WORQUE_PATH']

    def todo
      $stdout.puts Worque::Command::Todo.run(options)
    end
  end
end
