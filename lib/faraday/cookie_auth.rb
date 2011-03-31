require 'faraday'

module Faraday
  class Request::CookieAuth < Faraday::Middleware
    def call(env)
      env[:request_headers]['Cookie'] = @cookie
      @app.call(env)
    end

    def initialize(app, cookie)
      @app, @cookie = app, cookie
    end
  end
end
