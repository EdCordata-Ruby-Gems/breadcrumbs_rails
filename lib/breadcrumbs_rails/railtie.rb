module BreadcrumbsRails

  class Railtie < Rails::Railtie
    ActiveSupport.on_load(:action_controller) do
      views_path = "#{File.dirname(__FILE__)}/../generators/breadcrumbs/templates/app/views"
      ::ActionController::Base.append_view_path(views_path)
    end
  end

end
