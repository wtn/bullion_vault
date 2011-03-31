module BullionVault
  class Client
    module ViewBalance
      BALANCE_PATH = 'secure/view_balance_xml.do'.freeze

      def view_balance(options={}, raw=false)
        get BALANCE_PATH, options, raw
      end
    end
  end
end
