module Worque
  module Command
    extend self

    def run(options)
      path = options[:path] || raise(WrongOptions, "No path specified")
      mkdir(path)
      file = case options[:mode].to_sym
             when :today
               filename(path, Date.today)
             when :yesterday
               filename(path, Worque::BusinessDay.previous(Date.today))
             when :yesterday_hardcore
               filename(path, Worque::BusinessDay.previous_continuous(Date.today))
             end
      touch file
      return file
    end

    private

    def filename(dir, date)
      "#{dir}/checklist-#{date}.md"
    end

    def mkdir(dir)
      system("mkdir -p #{dir}")
    end

    def touch(path)
      system("touch #{path}")
    end

    class WrongOptions < ::StandardError; end
  end
end
