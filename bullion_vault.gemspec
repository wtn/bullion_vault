# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bullion_vault/version', __FILE__)

Gem::Specification.new do |s|
  s.add_development_dependency('rspec', '~> 2.5.0')
  s.add_development_dependency('webmock', '~> 1.6.2')
  s.add_development_dependency('rake', '~> 0.8.7')
  s.add_runtime_dependency('faraday_middleware', '~> 0.3.2')
  s.add_runtime_dependency('multi_xml', '~> 0.2.1')
  s.add_runtime_dependency('hashie', '~> 1.0.0')

  s.name = 'bullion_vault'
  s.version = BullionVault::VERSION.dup
  s.summary = %q{A Ruby wrapper for the BullionVault XML API}
  s.description = %q{A Ruby wrapper for the BullionVault XML API}
  s.homepage = 'https://github.com/wtn/bullion_vault'
  s.authors = ['William T Nelson']
  s.email = ['wtn@notational.net']
  s.post_install_message = nil
  s.rubyforge_project = nil
  s.platform = Gem::Platform::RUBY
  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if s.respond_to?(:required_rubygems_version=)
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
end
