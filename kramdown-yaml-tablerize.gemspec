require './lib/kramdown-yaml-tablerize/version'

Gem::Specification.new do |gem|
  gem.name        = 'kramdown-yaml-tablerize'
  gem.summary     = 'kramdown plugin to convert YAML to HTML tables.'
  gem.description = <<-END
      YAML Tablerize converts YAML to HTML Tables.
      Say goodbye to aligning tables in Markdown.
      This plugin allows YAML tables to be embedded
      in kramdown Markdown.
    END

  gem.version     = Kramdown::Parser::KRAMDOWN_YAML_TABLERIZE_VERSION
  gem.date        = '2014-06-30'

  gem.homepage    = 'https://github.com/IFTTT/yaml-tablerize'
  gem.authors     = ['Sean Zhu']
  gem.email       = 'sean.zhu@ifttt.com'
  gem.license     = 'IFTTT'

  gem.add_dependency 'kramdown', '~> 1.2', '>= 1.2.0'
  gem.add_dependency 'yaml-tablerize', '~> 0.2', '>= 0.2.0'
  gem.files       = `git ls-files`.split($RS)
  gem.require_paths = ["lib"]
end
