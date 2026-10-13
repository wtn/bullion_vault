require 'faraday'

module Faraday
  class Response::RaiseInvalidCookie < Faraday::Middleware
    def on_complete(env)
      if env[:response_headers]['set-cookie']
        raise BullionVault::InvalidCookie, error_message(env)
      end
    end

    private

    def error_message(env)
      "#{env[:method].to_s.upcase} #{env[:url]}: #{env[:status]}"
    end
  end
end
