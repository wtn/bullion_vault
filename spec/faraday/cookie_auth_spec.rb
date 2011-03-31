require File.expand_path('../../spec_helper', __FILE__)

describe Faraday::Request::CookieAuth do
  before(:each) do
    @client = BullionVault::Client.new(:cookie => 'monster')
  end

  it 'sets the cookie in requests' do
    stub_request(:get, 'https://live.bullionvault.com/secure/login.do')
      .with(:headers => {'Cookie' => 'monster'})
      .to_return(:status => 200)
    @client.get('secure/login.do', {}, true).should be_success
  end
end
