require 'faraday'
require File.expand_path('../version', __FILE__)

module BullionVault
  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :user_login,
      :user_password,
      :endpoint,
      :format,
      :proxy,
      :cookie,
      :user_agent
    ].freeze

    VALID_FORMATS = [:xml].freeze

    # The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    DEFAULT_USER_LOGIN = nil
    DEFAULT_USER_PASSWORD = nil
    DEFAULT_ENDPOINT = 'https://live.bullionvault.com/'.freeze
    DEFAULT_FORMAT = 'xml'.freeze
    DEFAULT_PROXY = nil
    DEFAULT_COOKIE = nil
    DEFAULT_USER_AGENT = "BullionVault Ruby Gem #{BullionVault::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Create a hash of options and their values
    def options
      Hash[VALID_OPTIONS_KEYS.map {|key| [key, public_send(key)] }]
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.user_login         = DEFAULT_USER_LOGIN
      self.user_password      = DEFAULT_USER_PASSWORD
      self.endpoint           = DEFAULT_ENDPOINT
      self.format             = DEFAULT_FORMAT
      self.proxy              = DEFAULT_PROXY
      self.cookie             = DEFAULT_COOKIE
      self.user_agent         = DEFAULT_USER_AGENT
      self
    end

    def authenticate
      client = Client.new
      client.authenticate ? (BullionVault.cookie = client.cookie and true) : false
    end
  end
end
