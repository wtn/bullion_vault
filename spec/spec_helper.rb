require File.expand_path('../../lib/bullion_vault', __FILE__)

require 'rspec'
require 'webmock/rspec'
require 'yaml'

RSpec.configure do |config|
  config.include WebMock::API
end

def stub_delete(path)
  stub_request(:delete, BullionVault.endpoint + path)
end

def stub_get(path)
  stub_request(:get, BullionVault.endpoint + path)
end

def stub_post(path)
  stub_request(:post, BullionVault.endpoint + path)
end

def stub_put(path)
  stub_request(:put, BullionVault.endpoint + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path << '/' << file.to_s)
end

def yaml_fixture(file)
  YAML.load fixture(file)
end
