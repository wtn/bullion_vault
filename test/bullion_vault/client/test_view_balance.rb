require "test_helper"

class BullionVault::Client::TestViewBalance < Minitest::Test
  def test_gets_balance
    stub_request(:get, 'https://live.bullionvault.com/secure/view_balance_xml.do')
      .with(:headers => {'Cookie' => 'monster'})
      .to_return(:status => 200, :body => fixture('view_balance.xml'))

    balance = BullionVault::Client.new(:cookie => 'monster').view_balance

    assert_equal yaml_fixture('view_balance.yaml'), balance
  end
end
