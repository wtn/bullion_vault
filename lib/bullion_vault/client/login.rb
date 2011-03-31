module BullionVault
  class Client
    module Login
      HTML_LOGIN_PATH = 'secure/login.do'.freeze
      XML_LOGIN_PATH = 'secure/j_security_check'.freeze

      def authenticate(raw=false)
        reset_cookie
        login(raw)
      end

      private

      def login(raw=false)
        resp = post(XML_LOGIN_PATH, login_credentials, true)
        raw and return resp
        resp.status == 302 and resp.headers['location'] == 'https://live.bullionvault.com/secure/main_frame.do'
      end

      def reset_cookie
        self.cookie = nil
        self.cookie = get(HTML_LOGIN_PATH, {}, true).headers['set-cookie']
      end
    end
  end
end
