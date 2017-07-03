require 'optparse'
require 'pathname'

module Worque
  module Command
    class Todo::Options
      attr_accessor :path
      attr_accessor :for
      attr_accessor :append_task
      attr_writer :skip_weekend
      attr_reader :template_path

      def initialize(opts)
        @path = opts[:path]
        @skip_weekend = opts[:skip_weekend]
        @for = opts[:for]
        @append_task = opts[:append_task]
        @template_path = opts.fetch(:template_path, nil)
      end

      def skip_weekend?
        !!@skip_weekend
      end
    end
  end
end
