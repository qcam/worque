require 'fileutils'

module Worque
  module Utils
    module Command
      extend self

      def mkdir(dir)
        FileUtils.mkdir_p(dir)
      end

      def touch(path)
        FileUtils.touch(path)
      end

      def append_text(path, text)
        File.open(path, 'a') do |f|
          f.puts "#{text}\n"
        end
      end
    end
  end
end
