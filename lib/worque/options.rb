require 'optparse'
require 'pathname'

module Worque
  class Options
    attr_accessor :path
    attr_accessor :mode
    attr_writer :skip_weekend

    DEFAULT_PATH_ENV_KEY = 'WORQUE_PATH'.freeze
    DEFAULT_PATH = ENV[DEFAULT_PATH_ENV_KEY]
    DEFAULT_SKIP_WEEKEND = true
    DEFAULT_OPTIONS = { path: DEFAULT_PATH, skip_weekend: DEFAULT_SKIP_WEEKEND, mode: :today }.freeze

    def initialize(opts = {})
      merged_opts = DEFAULT_OPTIONS.merge(opts)
      @path = merged_opts[:path]
      @skip_weekend = merged_opts[:skip_weekend]
      @mode = merged_opts[:mode]
    end

    def skip_weekend?
      !!@skip_weekend
    end

    def validate
      errors = []

      if !path || path == ''
        errors << "No path specified"
      end

      if ![:today, :yesterday].include?(mode)
        errors << "Only today and yesterday are supported"
      end

      errors
    end

    class InvalidError < ::StandardError; end

    class << self
      def parse(argv = [])
        default_opts = Worque::Options.new(DEFAULT_OPTIONS)

        OptionParser.new do |opts|
          opts.on('--path=PATH', 'Use path') do |path|
            default_opts.path = path
          end

          opts.on('--today', 'Create notes for today') do
            default_opts.mode = :today
          end

          opts.on('--yesterday', 'Create notes for yesterday') do
            default_opts.mode = :yesterday
          end

          opts.on('--[no-]skip-weekend', 'Use path') do |skip_weekend|
            default_opts.skip_weekend = skip_weekend
          end

          opts.on('-h', '--help', "Show help") do
            puts opts
            exit
          end
        end.parse!(argv)

        default_opts
      end
    end
  end
end
