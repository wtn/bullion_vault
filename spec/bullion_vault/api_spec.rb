require File.expand_path('../../spec_helper', __FILE__)

describe BullionVault::API do
  before(:each) do
    @keys = BullionVault::Configuration::VALID_OPTIONS_KEYS
  end

  context 'with module configuration' do

    before do
      BullionVault.configure do |config|
        @keys.each do |key|
          config.public_send("#{key}=", key)
        end
      end
    end

    after do
      BullionVault.reset
    end

    it 'inherits module configuration' do
      api = BullionVault::API.new
      @keys.each do |key|
        api.public_send(key).should == key
      end
    end

    context 'with class configuration' do

      before do
        @configuration = {
          :user_login => 'login',
          :user_password => 'secret',
          :adapter => :typhoeus,
          :endpoint => 'http://example.com/',
          :format => :xml,
          :proxy => 'http://user:passwd@proxy.example.com:8080',
          :cookie => 'COOKIE_DATA',
          :user_agent => 'Custom User Agent',
        }
      end

      context 'during initialization'

        it 'overrides module configuration' do
          api = BullionVault::API.new(@configuration)
          @keys.each do |key|
            api.public_send(key).should == @configuration[key]
          end
        end

      context 'after initilization' do

        it 'overrides module configuration after initialization' do
          api = BullionVault::API.new
          @configuration.each do |key, value|
            api.public_send("#{key}=", value)
          end
          @keys.each do |key|
            api.public_send(key).should == @configuration[key]
          end
        end
      end
    end
  end
end
