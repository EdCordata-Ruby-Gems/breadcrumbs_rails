$:.push File.expand_path('../lib', __FILE__)
require 'breadcrumbs_rails/version'

Gem::Specification.new do |s|
  s.name                  = 'breadcrumbs_rails'
  s.version               = BreadcrumbsRails::VERSION.dup
  s.platform              = Gem::Platform::RUBY
  s.authors               = 'EdCordata'
  s.description           = 'Rails breadcrumbs gem'
  s.summary               = 'Rails breadcrumbs gem'
  s.licenses              = ['CC BY 4.0']
  s.require_paths         = %w(lib)
  s.files                 = `git ls-files`.split("\n")
  s.homepage              = 'https://github.com/EdCordata-Ruby-Gems/breadcrumbs_rails'
  s.require_paths         = ['lib']
  s.required_ruby_version = '>= 1.9.3'
  s.rubygems_version      = '1.6.2'
  s.metadata      = {
    'documentation_uri' => 'https://github.com/EdCordata-Ruby-Gems/breadcrumbs_rails/blob/master/readme.md',
    'source_code_uri'   => 'https://github.com/EdCordata-Ruby-Gems/breadcrumbs_rails',
    'bug_tracker_uri'   => 'https://github.com/EdCordata-Ruby-Gems/breadcrumbs_rails/issues'
  }
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rails', '>= 3.0'
end
