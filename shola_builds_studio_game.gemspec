Gem::Specification.new do |spec|
    spec.name        = "shola_builds_studio_game"
    spec.version     = "2.0.0"
    spec.author      = "sholabuilds"
    spec.email       = "builder@sholabuilds.com"
    spec.summary     = "A game built to refresh my Ruby skills."
    spec.license     = "MIT"
  
    spec.files       = Dir["{bin,lib}/**/*"] + %w[LICENSE.txt README.md]
    spec.executables = ["studio_game"]
  
    spec.required_ruby_version = ">= 3.2.0"
end