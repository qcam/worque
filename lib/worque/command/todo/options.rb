require 'optparse'
require 'pathname'

module Worque
  module Command
    class Todo::Options
      attr_accessor :path
      attr_accessor :for
      attr_writer :skip_weekend

      def initialize(opts)
        @path = opts[:path]
        @skip_weekend = opts[:skip_weekend]
        @for = opts[:for]
      end

      def skip_weekend?
        !!@skip_weekend
      end
    end
  end
end
