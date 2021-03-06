# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fakefs/rmagick/version'

Gem::Specification.new do |spec|
  spec.name          = "fakefs-rmagick"
  spec.version       = FakeFS::Magick::VERSION
  spec.authors       = ["Éric Daspet"]
  spec.email         = ["eric.daspet+gem@survol.fr"]

  spec.summary       = %q{Be able to use Rmagick with FakeFS}
  spec.description   = %q{This is a quick'n dirty solution. It certainly covers only a few use cases.}
  spec.homepage      = "https://github.com/edas/fakefs-rmagick"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rmagick", "~> 2"
  spec.add_development_dependency "fakefs", "~> 0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
