require 'test_helper'
require 'worque/options'

describe Worque::Options do
  describe '#initialize' do
    it 'accepts mass assignments' do
      opts = Worque::Options.new(path: 'tmp', skip_weekend: true)

      assert opts.path == 'tmp'
      assert opts.skip_weekend?
    end
  end

  describe '.parse' do
    it 'parses command line options' do
      opts = Worque::Options.parse(['--path=tmp'])
      assert opts.path == 'tmp'
      assert opts.skip_weekend?

      opts = Worque::Options.parse(['--path=tmp', '--skip-weekend'])
      assert opts.path == 'tmp'
      assert opts.skip_weekend?
    end

    it 'parses --no-skip-weekend option' do
      opts = Worque::Options.parse(['--path=tmp', '--no-skip-weekend'])
      assert opts.path == 'tmp'
      assert !opts.skip_weekend?
    end

    it 'parses --today and --yesterday option' do
      opts = Worque::Options.parse(['--path=tmp', '--yesterday', '--no-skip-weekend'])
      assert opts.path == 'tmp'
      assert opts.mode, :yesterday

      opts = Worque::Options.parse(['--path=tmp', '--today', '--no-skip-weekend'])
      assert opts.path == 'tmp'
      assert opts.mode, :today
    end
  end
end
