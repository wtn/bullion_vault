require 'faraday'
require 'hashie/mash'

module Faraday
  class Response::Mashify < Faraday::Middleware
    def on_complete(env)
      env[:body] = Hashie::Mash.new(env[:body]) if env[:body].is_a?(Hash)
    end
  end
end
