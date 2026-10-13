require 'faraday'
require 'multi_xml'

module Faraday
  class Response::ParseXml < Faraday::Middleware
    def on_complete(env)
      body = env[:body]
      env[:body] = body.to_s.strip.empty? ? nil : MultiXML.parse(body)
    end
  end
end
