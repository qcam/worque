module Worque
  class Hash < ::Thor::CoreExt::HashWithIndifferentAccess; end

  class DefaultConfig
    attr_reader :data

    def initialize(data = ::Worque::Hash.new)
      @data = data
    end

    class << self
      def load!
        new(::Worque::Hash.new(parsed_config))
      end

      private

      def parsed_config
        JSON.parse(load_file)
      rescue Errno::ENOENT
        {}
      end

      def load_file
        File.read(config_file_path)
      end

      def config_file_path
        "#{Dir.home}/.worquerc"
      end
    end
  end
end
