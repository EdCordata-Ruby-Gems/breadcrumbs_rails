lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'breadcrumbs_rails/version'

Gem::Specification.new do |spec|
  spec.name                  = 'breadcrumbs_rails'
  spec.version               = BreadcrumbsRails::VERSION
  spec.authors               = %w(EdCordata)
  spec.summary               = %q{Rails breadcrumbs gem}
  spec.description           = %q{Rails breadcrumbs gem}
  spec.homepage              = 'https://github.com/EdCordata-Ruby-Gems/breadcrumbs_rails'
  spec.metadata              = {
    'documentation_uri' => 'https://github.com/EdCordata-Ruby-Gems/breadcrumbs_rails/blob/master/readme.md',
    'source_code_uri'   => 'https://github.com/EdCordata-Ruby-Gems/breadcrumbs_rails',
    'bug_tracker_uri'   => 'https://github.com/EdCordata-Ruby-Gems/breadcrumbs_rails/issues'
  }
  spec.license               = 'CC BY 4.0'
  spec.files                 = `git ls-files`.split($/)
  spec.require_paths         = %w(lib)
  spec.required_ruby_version = '>= 1.9.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rails', '>= 3.0'
end
