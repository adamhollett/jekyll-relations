lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/relations/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-relations'
  spec.version       = Jekyll::Relations::VERSION
  spec.authors       = ['Adam Hollett']
  spec.email         = ['mail@adamhollett.com']

  spec.summary       = 'Jekyll plugin to create relations between pages according to file structure.'
  spec.homepage      = 'https://github.com/adamhollett/jekyll-relations'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'jekyll',                         '~> 3.0'
  spec.add_development_dependency 'bundler',            '~> 1.16'
  spec.add_development_dependency 'rake',               '~> 10.0'
  spec.add_development_dependency 'minitest',           '~> 0'
  spec.add_development_dependency 'minitest-reporters', '~> 0'
end
