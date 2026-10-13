BullionVault Ruby Gem
====================
A Ruby wrapper for the BullionVault XML API

Installation
------------
    gem install bullion_vault

Usage Examples
--------------
    require 'rubygems'
    require 'bullion_vault'
    require 'pp'

    # Get current market data
    pp BullionVault.view_market

    # Certain methods require authentication. To get BullionVault credentials,
    # sign up at https://live.bullionvault.com/secure/registration.do

    BullionVault \
      .configure {|c| c.user_login, c.user_password = USERNAME, PASSWORD } \
      .authenticate
     => true

    # Check your account
    pp BullionVault.view_balance

    # You only need a valid session id to be authenticated
    BullionVault.cookie
     => "JSESSIONID=1D034E46B78C47C17005478B6537CABD; Path=/secure; Secure,
    logintest=\"Thu Mar 31 09:17:26 UTC 2011\"; Version=1; Max-Age=60000;
    Expires=Fri, 01-Apr-2011 01:57:26 GMT"
    cookie = 'JSESSIONID=1D034E46B78C47C17005478B6537CABD'
    BullionVault.cookie = cookie
    BullionVault.view_balance

    # Use two accounts at once
    BullionVault.reset
    c0 = BullionVault::Client.new(:user_login => 'sara_birton')
    c1 = BullionVault::Client.new(:user_login => 'bonepoppy')

Documentation
-------------
* [BullionVault XML API](http://www.bullionvault.com/help/?xml_api.html)
* [BullionVault Robots FAQs](http://www.bullionvault.com/help/index.do?content=FAQs/FAQs_bots.html)

Copyright
---------
Copyright (c) 2010-2011 William T Nelson, John Nunemaker, Wynn Netherland,
Erik Michaels-Ober, Steve Richert. See [MIT-LICENSE](https://github.com/wtn/bullion_vault/blob/master/MIT-LICENSE) for details.
