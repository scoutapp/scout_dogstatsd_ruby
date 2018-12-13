require 'scout_apm'

module ScoutDogstatsd
  # All access to the agent is thru this class method to ensure multiple Agent instances are not initialized per-Ruby process.
  def self.configure(dogstatsd_client)
    @@client ||= dogstatsd_client
    ScoutApm::Extensions::Config.add_transaction_callback(ScoutDogstatsd::TransactionCallback.new)
  end

  def self.client
    @@client
  end

  def self.rails?
    defined? Rails::Railtie
  end
end

require "scout_dogstatsd/version"
require "scout_dogstatsd/transaction_callback"
