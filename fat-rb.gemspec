Gem::Specification.new do |s|
  s.name = "fat-rb"
  s.version = "2.0.0"
  s.summary = "Ruby implementation of the Fat gem"
  s.description = s.summary
  s.authors = ["Lucas Tolchinsky"]
  s.email = ["lucas.tolchinsky@gmail.com"]
  s.homepage = "https://github.com/tonchis/fat-rb"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency "cutest", ">= 1.2.2"
end

