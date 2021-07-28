require 'breadcrumbs_rails/version'
require 'breadcrumbs_rails/railtie'
require 'breadcrumbs_rails/breadcrumb'
require 'breadcrumbs_rails/breadcrumbs'

module BreadcrumbsRails
  extend ActiveSupport::Concern


  # ----------------------------------------------------------
  included do |base|


    unless base.respond_to?(:before_action)
      base.alias_method :before_filter, :before_action
    end


    helper_method :render_breadcrumbs_title, :render_breadcrumbs


    def add_breadcrumb(name, options = {})
      self.breadcrumbs_gem.breadcrumbs << ::BreadcrumbsRails::Breadcrumb.new(
        name_string: name,
        path_string: options[:path],
        locale:      options[:locale],
        localize:    options[:localize],
      )

      self.breadcrumbs_gem.localize     = options[:localize] if options.has_key?(:localize)
      self.breadcrumbs_gem.locale       = options[:locale]   if options.has_key?(:locale)
      self.breadcrumbs_gem.scope        = options[:scope]    if options.has_key?(:scope)
      self.breadcrumbs_gem.title_string = options[:title]    if options.has_key?(:title)
    end


    def breadcrumbs_gem
      @breadcrumbs_gem ||= ::BreadcrumbsRails::Breadcrumbs.new
    end


    def render_breadcrumbs_title(default = nil)
      breadcrumbs_gem.title || default
    end


    def render_breadcrumbs(template: nil, &block)
      if block_given?
        yield(breadcrumbs_gem)
      else

        if template.nil?
          partial = 'breadcrumbs/breadcrumbs'
          partial = (breadcrumbs_gem.scope + '/' + partial) unless breadcrumbs_gem.scope.nil?
        else
          partial = "breadcrumbs/#{template}"
        end

        partial += '.html'

        render(partial:  partial,
               locals:   { breadcrumbs: breadcrumbs_gem },
               handlers: [:erb, :haml])
      end
    end


  end
  # ----------------------------------------------------------


  # ----------------------------------------------------------
  class_methods do

    def add_breadcrumb(name, options = {})
      before_action(options) do |controller|
        controller.send(:add_breadcrumb, name, options)
      end
    end

  end
  # ----------------------------------------------------------


end
