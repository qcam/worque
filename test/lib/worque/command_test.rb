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
        options = Worque::Options.new(path: nil)
        assert_raises do
          Worque::Command.run(options)
        end
      end
    end

    describe 'when directory does not exist' do
      it 'creates the directory' do
        options = Worque::Options.new(path: 'tmp/hello/word', mode: :today)
        Worque::Command.run(options)
        assert File.exists?(options.path)
      end
    end

    describe 'when no mode is specified' do
      it 'creates the file for today' do
        options = Worque::Options.new(path: 'tmp/hello/word')

        Timecop.freeze(Date.new(2016, 7, 15)) do
          Worque::Command.run(options)

          assert File.exists?("#{options.path}/checklist-2016-07-15.md")
        end
      end
    end

    describe 'when mode is yesterday' do
      it 'creates the file for yesterday' do
        options = Worque::Options.new(path: 'tmp/hello/word', mode: :yesterday)

        Timecop.freeze(Date.new(2016, 7, 15)) do
          Worque::Command.run(options)

          assert File.exists?("#{options.path}/checklist-2016-07-14.md")
        end
      end
    end
  end
end
