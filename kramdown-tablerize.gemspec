require './lib/kramdown-tablerize/version'

Gem::Specification.new do |gem|
  gem.name          = 'kramdown-tablerize'
  gem.summary       = 'Use Tablerize to convert YAML tables in Markdown to HTML.'
  gem.description   = <<-END
      A kramdown plugin to convert YAML to HTML tables inside Markdown, using
      Tablerize.
    END

  gem.version       = Tablerize::Plugin::Kramdown::VERSION

  gem.homepage      = 'https://github.com/IFTTT/kramdown-tablerize'
  gem.authors       = ['Sean Zhu']
  gem.email         = 'opensource+tablerize@szhu.me'
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_dependency 'kramdown', '~> 1.2', '>= 1.2.0'
  gem.add_dependency 'tablerize', '~> 1.0', '>= 1.0.0'
  gem.executables   = ['kramdown-tablerize']
  gem.files         = `git ls-files`.split
  gem.require_paths = ['lib']
end
