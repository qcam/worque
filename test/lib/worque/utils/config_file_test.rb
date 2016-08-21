require 'test_helper'
require 'worque/default_config'

describe Worque::DefaultConfig do
  describe '#initialize' do
    it 'takes config' do
      config = Worque::DefaultConfig.new(path: '/foo', slack_token: 'bar')
      assert_equal({path: '/foo', slack_token: 'bar'}, config.data)
    end
  end

  describe '#load!' do
    describe 'if ~/.worquerc exists' do
      it 'loads from ~/.worquerc' do
        worquerc = {'foo' => 'bar'}.to_json

        File.stub(:read, worquerc) do
          config = Worque::DefaultConfig.load!
          assert_kind_of(Worque::Hash, config.data)
          assert_equal({ 'foo' => 'bar' }, config.data)
        end
      end
    end

    describe 'if ~/.worquerc does not exist' do
      it 'returns an empty hash' do
        error_invocation = Proc.new { raise Errno::ENOENT }

        File.stub(:read, error_invocation) do
          config = Worque::DefaultConfig.load!
          assert_equal({}, config.data)
        end
      end
    end
  end
end
