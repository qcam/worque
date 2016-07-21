require "worque/version"
require 'worque/business_day'
require 'worque/command'

module Worque
  extend self

  def configs
    @configs ||= {
      path: ENV['WORQUE_PATH'],
      mode: :today,
      hardcore: ENV['WORQUE_HARDCORE'].downcase == 'true'
    }
  end

  def configure
    yield(configs)
  end
end
