require 'spec_helper'

describe BullionVault::Client::ViewMarket do
  before(:each) do
    @client = BullionVault::Client.new
  end

  describe '#view_market' do
    it 'gets market offers' do
      stub_request(:get, 'https://live.bullionvault.com/view_market_xml.do')
        .to_return(:status => 200, :body => fixture('view_market.xml'))

      @client.view_market.should eq yaml_fixture('view_market.yaml')
    end
  end
end
