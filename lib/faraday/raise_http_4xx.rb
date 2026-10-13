require 'faraday'

module Faraday
  class Response::RaiseHttp4xx < Faraday::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 400
        raise BullionVault::BadRequest, error_message(env)
      when 401
        raise BullionVault::Unauthorized, error_message(env)
      when 403
        raise BullionVault::Forbidden, error_message(env)
      when 404
        raise BullionVault::NotFound, error_message(env)
      when 406
        raise BullionVault::NotAcceptable, error_message(env)
      end
    end

    private

    def error_message(env)
      "#{env[:method].to_s.upcase} #{env[:url]}: #{env[:status]}#{error_body(env[:body])}"
    end

    def error_body(body)
      return unless body.is_a?(Hash)

      if body['error']
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
