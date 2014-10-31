Gem::Specification.new do |s|
  s.name = "fat-rb"
  s.version = "0.1.1"
  s.summary = "Ruby implementation of the Fat gem"
  s.description = s.summary
  s.authors = ["Lucas Tolchinsky"]
  s.email = ["lucas.tolchinsky@gmail.com"]
  s.homepage = "https://github.com/tonchis/fat-rb"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_development_dependency "cutest"
end

