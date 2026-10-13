require 'faraday'

module Faraday
  class Request::CookieAuth < Faraday::Middleware
    def initialize(app, cookie)
      super(app)
      @cookie = cookie
    end

    def on_request(env)
      env[:request_headers]['Cookie'] = @cookie
    end
  end
end
