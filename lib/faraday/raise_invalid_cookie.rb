require 'faraday'

module Faraday
  class Response::RaiseInvalidCookie < Response::Middleware
    def self.register_on_complete(env)
      env[:response].on_complete do |response|
        if response[:response_headers]['set-cookie']
          raise BullionVault::InvalidCookie, error_message(response)
        end
      end
    end

    private

    def self.error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{error_body(response[:body])}"
    end

    def self.error_body(body)
      if body.nil?
        nil
      elsif body['error']
        ": #{body['error']}"
      elsif body['errors']
        first = body['errors'].to_a.first
        if first.kind_of? Hash
          ": #{first['message'].chomp}"
        else
          ": #{first.chomp}"
        end
      end
    end
  end
end
