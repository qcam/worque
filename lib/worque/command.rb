require 'worque/command/todo'
module Worque
  module Command
    extend self

    def run(options)
      Todo.new(options).call()
    end
  end
end
