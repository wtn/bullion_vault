require File.expand_path('../../spec_helper', __FILE__)

describe Faraday::Response do
  before do
    @client = BullionVault::Client.new
  end

  context 'when the cookie is set' do
    it 'raises InvalidCookieError' do
      stub_request(:get, 'https://live.bullionvault.com/action.do')
        .to_return(:status => 200, :headers => {'set-cookie' => 'monster'})

      @client.cookie = 'illegitimate_value'
      proc { @client.get('action.do') }.should raise_error(BullionVault::InvalidCookie)
    end
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
    context "when HTTP status is #{status}" do

      before do 
        stub_request(:get, 'https://live.bullionvault.com/error_inducing_action.do')
          .to_return(:status => status)
      end

      it "raises #{exception.name} error" do
        proc { @client.get('error_inducing_action.do') }.should raise_error(exception)
      end
    end
  end
end
