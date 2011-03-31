require File.expand_path('../../spec_helper', __FILE__)

describe BullionVault::Client do
  before(:each) do
    @client = BullionVault::Client.new
  end

  it 'connects to the endpoint configuration' do
    endpoint = URI.parse(@client.api_endpoint).to_s
    connection = @client.send(:connection).build_url(nil).to_s
    connection.should == endpoint
  end
end
