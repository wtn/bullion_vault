require "test_helper"

class Faraday::Request::TestCookieAuth < Minitest::Test
  def test_sets_the_cookie_in_requests
    stub_request(:get, 'https://live.bullionvault.com/secure/login.do')
      .with(:headers => {'Cookie' => 'monster'})
      .to_return(:status => 200)

    client = BullionVault::Client.new(:cookie => 'monster')

    assert client.get('secure/login.do', {}, true).success?
  end
end
