require 'test_helper'

describe Worque::Command::Todo::Action do
  after do
    # Clean up tmp directory
    system('rm -rf tmp/*')
  end

  let(:action) { Worque::Command::Todo::Action }

  describe '#call' do
    describe 'when directory does not exist' do
      it 'creates the directory' do
        options = { path: 'tmp/hello/word', for: 'today' }
        action.run(options)
        assert File.exists?(options[:path])
      end
    end

    describe 'when mode is yesterday' do
      it 'creates the file for yesterday' do
        options = { path: 'tmp/hello/word', for: :yesterday }

        Timecop.freeze(Date.new(2016, 7, 15)) do
          action.run(options)

          assert File.exists?("#{options[:path]}/notes-2016-07-14.md")
        end
      end
    end

    describe 'when mode is adding task' do
      it 'append task title to notes' do
        options = { path: 'tmp/hello/word', for: 'today', append_task: 'foo' }

        Timecop.freeze(Date.new(2016, 7, 24)) do
          action.run(options)

          assert File.exists?("#{options[:path]}/notes-2016-07-24.md")
          assert File.readlines("#{options[:path]}/notes-2016-07-24.md").grep(/foo/).any?
        end
      end
    end
  end
end
