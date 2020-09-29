require_relative 'lib/ripli/version'


Gem::Specification.new do |spec|
  spec.name          = "ripli"
  spec.version       = Ripli::VERSION
  spec.authors       = ["linuxander"]
  spec.email         = ["linuxander@secmail.pro"]

  spec.summary       = %q{ Get proxychains lists of proxy servers. }
  spec.description   = %q{ Ripli scrap certain proxy sites and save proxies in proxychains format (type-ip-port). }
  spec.homepage      = "https://www.cybersecrs.github.io/ripli"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/cybersecrs/ripli"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
