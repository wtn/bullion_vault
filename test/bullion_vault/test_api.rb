require "test_helper"

class BullionVault::TestAPI < Minitest::Test
  KEYS = BullionVault::Configuration::VALID_OPTIONS_KEYS

  CONFIGURATION = {
    :user_login => 'login',
    :user_password => 'secret',
    :adapter => :typhoeus,
    :endpoint => 'http://example.com/',
    :format => :xml,
    :proxy => 'http://user:passwd@proxy.example.com:8080',
    :cookie => 'COOKIE_DATA',
    :user_agent => 'Custom User Agent',
  }.freeze

  def setup
    BullionVault.configure do |config|
      KEYS.each {|key| config.public_send("#{key}=", key) }
    end
  end

  def test_inherits_module_configuration
    api = BullionVault::API.new
    KEYS.each {|key| assert_equal key, api.public_send(key) }
  end

  def test_overrides_module_configuration_during_initialization
    api = BullionVault::API.new(CONFIGURATION)
    KEYS.each {|key| assert_equal CONFIGURATION[key], api.public_send(key) }
  end

  def test_overrides_module_configuration_after_initialization
    api = BullionVault::API.new
    CONFIGURATION.each {|key, value| api.public_send("#{key}=", value) }
    KEYS.each {|key| assert_equal CONFIGURATION[key], api.public_send(key) }
  end
end
