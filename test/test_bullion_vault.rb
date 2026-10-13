require "test_helper"

class TestBullionVault < Minitest::Test
  OPTIONS_KEYS = %w{adapter user_login user_password endpoint format proxy cookie user_agent}

  def test_that_it_has_a_version_number
    refute_nil ::BullionVault::VERSION
  end

  def test_delegates_to_a_client
    stub_request(:get, 'https://live.bullionvault.com/view_market_xml.do')
      .to_return(:body => fixture('view_market.xml'))

    assert_equal BullionVault::Client.new.view_market, BullionVault.view_market
    assert_requested :get, 'https://live.bullionvault.com/view_market_xml.do', :times => 2
  end

  def test_client_is_a_client
    assert_kind_of BullionVault::Client, BullionVault.client
  end

  def test_valid_options_keys
    assert_equal OPTIONS_KEYS.map(&:to_sym), BullionVault::Configuration::VALID_OPTIONS_KEYS
  end

  OPTIONS_KEYS.each do |key|
    define_method("test_default_#{key}") do
      expected = BullionVault::Configuration.const_get("default_#{key}".upcase)
      expected.nil? ? assert_nil(BullionVault.public_send(key)) : assert_equal(expected, BullionVault.public_send(key))
    end

    define_method("test_set_#{key}") do
      BullionVault.public_send("#{key}=", 'test_value')
      assert_equal 'test_value', BullionVault.public_send(key)
    end

    define_method("test_configure_#{key}") do
      BullionVault.configure {|config| config.public_send("#{key}=", key) }
      assert_equal key, BullionVault.public_send(key)
    end
  end
end
