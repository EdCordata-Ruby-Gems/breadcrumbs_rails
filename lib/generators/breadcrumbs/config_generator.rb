module Breadcrumbs
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root ::File.expand_path(::File.join(::File.dirname(__FILE__), 'templates/config/initializers'))

      def copy_config_file
        template 'breadcrumbs_config.rb', 'config/initializers/breadcrumbs.rb'
      end
    end
  end
end
