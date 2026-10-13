require "test_helper"

class BullionVault::Client::TestLogin < Minitest::Test
  LOGIN_URL = 'https://live.bullionvault.com/secure/j_security_check'.freeze

  def setup
    @client = BullionVault::Client.new(
      :user_login => 'user',
      :user_password => 'pass',
      :cookie => 'monster',
    )
  end

  def test_reset_cookie_uses_new_value_from_server
    @client.cookie = nil
    stub_request(:get, 'https://live.bullionvault.com/secure/login.do')
      .to_return(:status => 200, :headers => {'set-cookie' => 'fresh'})

    assert_equal 'fresh', @client.send(:reset_cookie)
    assert_equal 'fresh', @client.cookie
  end

  def test_login_posts_form_encoded_credentials
    stub_login.to_return(:status => 302, :headers => {'location' => 'https://live.bullionvault.com/secure/main_frame.do'})

    assert @client.send(:login)
  end

  def test_login_fails_on_unexpected_redirect
    stub_login.to_return(:status => 302, :headers => {'location' => 'https://live.bullionvault.com/secure/surprise.do'})

    refute @client.send(:login)
  end

  def test_login_fails_on_non_redirect
    stub_login.to_return(:status => 200)

    refute @client.send(:login)
  end

  private

  def stub_login
    stub_request(:post, LOGIN_URL).with(
      :body => {'j_username' => 'user', 'j_password' => 'pass'},
      :headers => {
        'Cookie' => 'monster',
        'Content-Type' => 'application/x-www-form-urlencoded',
      },
    )
  end
end
