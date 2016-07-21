require 'test_helper'

describe Worque::Command::Todo do
  after do
    # Clean up tmp directory
    system('rm -rf tmp/*')
  end

  describe '#call' do
    describe 'when directory does not exist' do
      it 'creates the directory' do
        options = { path: 'tmp/hello/word', for: 'today' }
        Worque::Command::Todo.run(options)
        assert File.exists?(options[:path])
      end
    end

    describe 'when mode is yesterday' do
      it 'creates the file for yesterday' do
        options = { path: 'tmp/hello/word', for: :yesterday }

        Timecop.freeze(Date.new(2016, 7, 15)) do
          Worque::Command::Todo.run(options)

          assert File.exists?("#{options[:path]}/notes-2016-07-14.md")
        end
      end
    end
  end
end
