require_relative "lib/bullion_vault/version"

Gem::Specification.new do |spec|
  spec.name = "bullion_vault"
  spec.version = BullionVault::VERSION
  spec.authors = ["William T. Nelson"]
  spec.email = ["35801+wtn@users.noreply.github.com"]

  spec.summary = "A Ruby wrapper for the BullionVault XML API"
  spec.homepage = "https://github.com/wtn/bullion_vault"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('faraday', '~> 2.12')
  spec.add_dependency('multi_xml', '~> 0.9')
  spec.add_dependency('rexml', '~> 3.3')
  spec.add_dependency('hashie', '~> 5.0')
end
