module Breadcrumbs
  module Generators
    class ViewsGenerator < ::Rails::Generators::NamedBase
      source_root ::File.expand_path(::File.join(::File.dirname(__FILE__), 'templates/app/views/breadcrumbs'))
      desc 'Template engine for the views. Available options are "erb", "haml".'

      class_option :format, type: :string, default: 'all'

      def copy_default_views
        case options['format'].try(:to_s).try(:downcase)
        when 'haml'
          copy_file("_#{@name}.html.haml", 'app/views/breadcrumbs/_breadcrumbs.html.haml')
        when 'erb'
          copy_file("_#{@name}.html.erb", 'app/views/breadcrumbs/_breadcrumbs.html.erb')
        else
          copy_file("_#{@name}.html.haml", 'app/views/breadcrumbs/_breadcrumbs.html.haml')
          copy_file("_#{@name}.html.erb", 'app/views/breadcrumbs/_breadcrumbs.html.erb')
        end
      end
    end
  end
end
