require "test_helper"

class BullionVault::Client::TestViewMarket < Minitest::Test
  def test_gets_market_offers
    stub_request(:get, 'https://live.bullionvault.com/view_market_xml.do')
      .to_return(:status => 200, :body => fixture('view_market.xml'))

    market = BullionVault::Client.new.view_market

    assert_equal yaml_fixture('view_market.yaml'), market
    assert_kind_of Hashie::Mash, market
  end
end
