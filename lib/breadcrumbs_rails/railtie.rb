module BreadcrumbsRails
  class Railtie < Rails::Railtie

    ActiveSupport.on_load(:action_controller) do
      ::ActionController::Base.send(:include, BreadcrumbsRails::ActionController)
      views_path = "#{File.dirname(__FILE__)}/../generators/breadcrumbs/templates/app/views/breadcrumbs"
      ::ActionController::Base.prepend_view_path(views_path)
    end

  end
end
