require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each {|f| require f}

module BullionVault
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'User-Agent' => user_agent},
        :proxy => proxy,
        :ssl => {:verify => false},
        :url => api_endpoint,
      }

      Faraday::Connection.new(options) do |connection|
        cookie and connection.use Faraday::Request::CookieAuth, cookie
        connection.adapter(adapter)
        connection.use Faraday::Response::RaiseHttp5xx
        parse_xml?(raw).tap do |parse_xml|
          connection.use Faraday::Response::ParseXml if parse_xml
          connection.use Faraday::Response::RaiseHttp4xx
          cookie and connection.use Faraday::Response::RaiseInvalidCookie
          connection.use Faraday::Response::Mashify if parse_xml
        end
      end
    end

    def parse_xml?(raw)
      ! raw and format.to_s.downcase == 'xml'
    end
  end
end
