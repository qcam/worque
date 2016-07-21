require 'test_helper'

describe Worque::Utils::Command do
  before do
    @helper = Worque::Utils::Command
    system('rm -rf tmp/*')
  end

  after do
    system('rm -rf tmp/*')
  end

  describe '.mkdir' do
    it 'makes new dir' do
      path = "#{ Dir.pwd }/tmp/hello/world"
      @helper.mkdir(path)
      assert Dir.exists?(path)
    end

    describe 'no permission' do
      it 'raises error' do
        path = '/some/path/not/allowed'

        assert_raises do
          @helper.mkdir(path)
        end

        assert !Dir.exists?(path)
      end
    end
  end

  describe '.touch' do
    it 'creates file if it does not exist' do
      dir = 'tmp'
      @helper.mkdir(dir)

      path = 'tmp/text.txt'
      @helper.touch(path)
      assert File.exists?(path)
    end
  end
end

