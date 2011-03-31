require 'spec_helper'

describe BullionVault::Client::Login do
  describe '#reset_cookie' do
    before(:each) do
      @client = BullionVault::Client.new(:user_login => 'user', :user_password => 'pass')
    end

    it 'resets the cookie with a new value from the server' do
      stub_request(:get, 'https://live.bullionvault.com/secure/login.do')
        .to_return(:status => 200, :headers => {'set-cookie' => 'monster'})

      @client.send(:reset_cookie).should eq 'monster'
      @client.cookie.should eq 'monster'
    end
  end

  describe '#login' do
    before(:each) do
      @client = BullionVault::Client.new(
        :user_login => 'user',
        :user_password => 'pass',
        :cookie => 'monster',
      )
    end

    it 'posts the login credentials' do
      stub_request(:post, 'https://live.bullionvault.com/secure/j_security_check')
        .with(:body => 'j_username=user&j_password=pass', :headers => {'Cookie' => 'monster'})
        .to_return(:status => 302, :headers => {'location' => 'https://live.bullionvault.com/secure/main_frame.do'})

      @client.send(:login).should be_true
    end

    it 'fails when the server redirects to an unexpected URL' do
      stub_request(:post, 'https://live.bullionvault.com/secure/j_security_check')
        .with(:body => 'j_username=user&j_password=pass', :headers => {'Cookie' => 'monster'})
        .to_return(:status => 302, :headers => {'location' => 'https://live.bullionvault.com/secure/surprise.do'})

      @client.send(:login).should be_false
    end

    it 'fails when the server returns a response other than 302' do
      stub_request(:post, 'https://live.bullionvault.com/secure/j_security_check')
        .with(:body => 'j_username=user&j_password=pass', :headers => {'Cookie' => 'monster'})
        .to_return(:status => 200, :headers => {'location' => 'https://live.bullionvault.com/secure/surprise.do'})

      @client.send(:login).should be_false
    end
  end
end
