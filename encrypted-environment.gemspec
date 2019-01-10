# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "encrypted/environment/version"

Gem::Specification.new do |spec|
  spec.name          = "encrypted-environment"
  spec.version       = Encrypted::Environment::VERSION
  spec.authors       = ["Pedro Piñera"]
  spec.email         = ["pedro@ppinera.es"]
  spec.summary       = 'Load encrypted variables into the environment'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_dependency "ejson", "~> 1.2"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop", "~> 0.60.0"
  spec.add_development_dependency "byebug", "~> 10.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.3"
  spec.add_development_dependency "mocha", "~> 1.7"
end
