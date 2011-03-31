require File.expand_path('../bullion_vault/error', __FILE__)
require File.expand_path('../bullion_vault/configuration', __FILE__)
require File.expand_path('../bullion_vault/api', __FILE__)
require File.expand_path('../bullion_vault/client', __FILE__)
require File.expand_path('../bullion_vault/connection', __FILE__)
require File.expand_path('../bullion_vault/request', __FILE__)

module BullionVault
  extend Configuration

  def self.client(options={})
    BullionVault::Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super if ! client.respond_to?(method)
    client.public_send(method, *args, &block)
  end

  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end
