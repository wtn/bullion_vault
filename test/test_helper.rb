$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "bullion_vault"

require "minitest/autorun"
require "webmock/minitest"
require "yaml"

module FixtureHelpers
  def fixture_path
    File.expand_path('../fixtures', __FILE__)
  end

  def fixture(file)
    File.read(File.join(fixture_path, file.to_s))
  end

  def yaml_fixture(file)
    YAML.safe_load(fixture(file))
  end
end

module ResetConfiguration
  def teardown
    super
    BullionVault.reset
  end
end

Minitest::Test.include FixtureHelpers
Minitest::Test.prepend ResetConfiguration
