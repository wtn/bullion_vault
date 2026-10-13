require "test_helper"

class Faraday::TestResponse < Minitest::Test
  def setup
    @client = BullionVault::Client.new
  end

  def test_raises_invalid_cookie_when_server_resets_cookie
    stub_request(:get, 'https://live.bullionvault.com/action.do')
      .to_return(:status => 200, :headers => {'set-cookie' => 'monster'})

    @client.cookie = 'illegitimate_value'

    assert_raises(BullionVault::InvalidCookie) { @client.get('action.do') }
  end

  {
    400 => BullionVault::BadRequest,
    401 => BullionVault::Unauthorized,
    403 => BullionVault::Forbidden,
    404 => BullionVault::NotFound,
    406 => BullionVault::NotAcceptable,
    500 => BullionVault::InternalServerError,
    502 => BullionVault::BadGateway,
    503 => BullionVault::ServiceUnavailable,
  }.each do |status, exception|
    define_method("test_raises_#{exception.name.split('::').last}_on_#{status}") do
      stub_request(:get, 'https://live.bullionvault.com/error_inducing_action.do')
        .to_return(:status => status)

      error = assert_raises(exception) { @client.get('error_inducing_action.do') }
      assert_includes error.message, "GET https://live.bullionvault.com/error_inducing_action.do: #{status}"
    end
  end
end
