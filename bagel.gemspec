# frozen_string_literal: true

require_relative "lib/bagel/version"

Gem::Specification.new do |spec|
  spec.name          = "bagel"
  spec.version       = Bagel::VERSION
  spec.authors       = ["Brent Chuang"]
  spec.email         = ["burennto@gmail.com"]

  spec.summary       = "Bagel is a tennis video editor/annotator."
  spec.homepage      = "https://github.com/burennto/bagel"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rmagick", "~> 4.2", ">= 4.2.2"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.7"
  spec.add_development_dependency "factory_bot", "~> 6.2"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
