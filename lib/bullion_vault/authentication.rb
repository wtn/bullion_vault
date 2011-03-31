module BullionVault
  module Authentication
    private

    def login_credentials
      { :j_username => user_login, :j_password => user_password }
    end
  end
end
