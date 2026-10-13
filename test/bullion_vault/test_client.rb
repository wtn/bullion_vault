require "test_helper"

class BullionVault::TestClient < Minitest::Test
  def setup
    @client = BullionVault::Client.new
  end

  def test_connects_to_the_endpoint
    connection = @client.send(:connection)
    assert_equal URI.parse(@client.api_endpoint).to_s, connection.build_url(nil).to_s
  end

  def test_verifies_tls_certificates
    assert @client.send(:connection).ssl.verify?
  end
end
