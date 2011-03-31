require File.expand_path('../spec_helper', __FILE__)
require 'spec_helper'

describe BullionVault do
  after do
    BullionVault.reset
  end

  context 'when delegating to a client' do
    before do
      stub_request(:get, 'https://live.bullionvault.com/view_market_xml.do')
        .to_return(:body => fixture('view_market.xml'))
    end

    it 'gets the correct resource' do
      BullionVault.view_market
      a_request(:get, 'https://live.bullionvault.com/view_market_xml.do')
        .should have_been_made
    end

    it 'returns the same results as a client' do
      BullionVault.view_market.should == BullionVault::Client.new.view_market
    end
  end

  describe '.client' do
    it 'is a BullionVault::Client' do
      BullionVault.client.should be_a BullionVault::Client
    end
  end

  OPTIONS_KEYS = %w{adapter user_login user_password endpoint format proxy cookie user_agent}

  describe 'VALID_OPTIONS_KEYS' do
    it 'matches the list in the spec' do
      OPTIONS_KEYS.map(&:to_sym).should eq BullionVault::Configuration::VALID_OPTIONS_KEYS
    end
  end

  OPTIONS_KEYS.each do |key|
    describe ".#{key}" do
      it "returns the default #{key}" do
        BullionVault.public_send(key).should eq BullionVault::Configuration.const_get("default_#{key}".upcase)
      end
    end

    describe ".#{key}=" do
      it "sets the #{key}" do
        BullionVault.public_send("#{key}=", 'test_value')
        BullionVault.public_send(key).should eq 'test_value'
      end
    end
  end

  describe '.configure' do
    BullionVault::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "sets the #{key}" do
        BullionVault.configure do |config|
          config.public_send("#{key}=", key)
          BullionVault.public_send(key).should == key
        end
      end
    end
  end
end
