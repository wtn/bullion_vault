require 'faraday'

module Faraday
  class Response::RaiseHttp5xx < Faraday::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 500
        raise BullionVault::InternalServerError, error_message(env, 'Something is technically wrong.')
      when 502
        raise BullionVault::BadGateway, error_message(env, 'BullionVault is down or being upgraded.')
      when 503
        raise BullionVault::ServiceUnavailable, error_message(env, '(__-){ BullionVault is over capacity.')
      end
    end

    private

    def error_message(env, body=nil)
      "#{env[:method].to_s.upcase} #{env[:url]}: #{[env[:status].to_s + ':', body].compact.join(' ')} Check http://goldnews.bullionvault.com/ for updates on the status of the BullionVault service."
    end
  end
end
