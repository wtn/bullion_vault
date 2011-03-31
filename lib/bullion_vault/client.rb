module BullionVault
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each {|f| require f }

    alias :api_endpoint :endpoint

    include BullionVault::Client::Login
    include BullionVault::Client::ViewMarket
    include BullionVault::Client::ViewBalance
  end
end
