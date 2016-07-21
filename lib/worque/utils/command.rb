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
    end
  end
end
