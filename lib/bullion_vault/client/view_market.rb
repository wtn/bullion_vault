module BullionVault
  class Client
    module ViewMarket
      MARKET_PATH = 'view_market_xml.do'.freeze

      def view_market(options={}, raw=false)
        get MARKET_PATH, options, raw
      end
    end
  end
end
