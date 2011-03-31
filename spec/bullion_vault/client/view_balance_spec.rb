require 'spec_helper'

describe BullionVault::Client::ViewBalance do
  before(:each) do
    @client = BullionVault::Client.new(:cookie => 'monster')
  end

  describe '#view_market' do
    it 'gets market offers' do
      stub_request(:get, 'https://live.bullionvault.com/view_market_xml.do')
        .with(:headers => {'Cookie' => 'monster'})
        .to_return(:status => 200, :body => fixture('view_balance.xml'))

      @client.view_market.should eq yaml_fixture('view_balance.yaml')
    end
  end
end
