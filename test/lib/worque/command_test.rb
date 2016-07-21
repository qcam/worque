require 'test_helper'
require 'worque/command'

describe Worque::Command do
  after do
    # Clean up tmp directory
    system('rm -rf tmp/*')
  end

  describe '.run' do
    describe  'when path is not set' do
      it 'raises error' do
        options = {}
        assert_raises Worque::Command::WrongOptions do
          Worque::Command.run(options)
        end
      end
    end

    describe 'when directory does not exist' do
      it 'creates the directory' do
        options = { path: 'tmp/hello/word', mode: :today }
        Worque::Command.run(options)
        assert File.exists?(options[:path])
      end
    end

    describe 'when mode is yesterday' do
      it 'creates the file ' do
        skip("Implement later")
      end
    end
  end
end
