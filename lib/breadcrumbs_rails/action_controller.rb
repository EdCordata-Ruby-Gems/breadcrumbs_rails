module BreadcrumbsRails
  module ActionController
    extend ActiveSupport::Concern


    # -----------------------------------------------------------
    included do |base|
      extend ClassMethods
      helper HelperMethods

      helper_method :add_breadcrumb, :breadcrumbs_gem

      unless base.respond_to?(:before_action)
        base.alias_method :before_action, :before_filter
      end
    end
    # -----------------------------------------------------------


    protected


    # -----------------------------------------------------------
    def add_breadcrumb(name, options = {})
      url_helpers = Rails.application.routes.url_helpers

      if options[:path]
        options[:path] = if url_helpers.methods.include?(options[:path])
                           url_helpers.send(options[:path])
                         else
                           options[:path]
                         end
      end

      self.breadcrumbs_gem[:breadcrumbs] << {
        name:      name,
        path:      options[:path].to_s,
        params:    options[:params] || {},
        title:     options[:title],
        html_safe: options[:html_safe] == true
      }

      self.breadcrumbs_gem[:localize]  = options[:localize]  == true unless options[:localize].nil?
      self.breadcrumbs_gem[:html_safe] = options[:html_safe] == true unless options[:html_safe].nil?
    end

    def breadcrumbs_gem
      @breadcrumbs_gem ||= { breadcrumbs: [], scope: nil, localize: false }
    end
    # -----------------------------------------------------------


    # Class Methods
    # -----------------------------------------------------------
    module ClassMethods

      def add_breadcrumb(name, options = {})
        before_action(options) do |controller|
          controller.send(:add_breadcrumb, name, options)
        end
      end

    end
    # -----------------------------------------------------------


    # Helper Methods
    # -----------------------------------------------------------
    module HelperMethods


      def render_breadcrumbs_title(default = nil)
        return default if breadcrumbs_gem[:breadcrumbs].last[:title].nil?
        return ''      if breadcrumbs_gem[:breadcrumbs].last[:title].to_s.blank?

        if breadcrumbs_gem[:localize]
          I18n.t(breadcrumbs_gem[:breadcrumbs].last[:title])
        else
          breadcrumbs_gem[:breadcrumbs].last[:title]
        end
      end


      def render_breadcrumbs(options = {}, &block)
        format = (options[:format] || :html).to_sym

        if block_given?
          yield(breadcrumbs_gem)
        else

          case format

            when :html
              content_tag(:ul) do
                breadcrumbs_gem[:breadcrumbs].map do |breadcrumb|
                  concat content_tag(:li, breadcrumbs_name_or_link(breadcrumbs_gem, breadcrumb))
                end
              end

            when :bootstrap
              content_tag(:ul, class: 'pagination') do
                breadcrumbs_gem[:breadcrumbs].map do |breadcrumb|
                  concat content_tag(:li, breadcrumbs_name_or_link(breadcrumbs_gem, breadcrumb))
                end
              end

            when :inspinia
              html = ''
              html << '<div class="row wrapper border-bottom white-bg page-heading">'
              html << '  <div class="col-lg-9">'
              html << (render_breadcrumbs_title ? "<h2>#{render_breadcrumbs_title}</h2>" : '<br/>')
              html << '    <ol class="breadcrumb">'

              breadcrumbs_gem[:breadcrumbs].each_with_index do |breadcrumb, index|
                if (index + 1) == breadcrumbs_gem[:breadcrumbs].length
                  html << "<li class='active'><strong>#{breadcrumbs_name_or_link(breadcrumbs_gem, breadcrumb)}</strong></li>"
                else
                  html << "<li>#{breadcrumbs_name_or_link(breadcrumbs_gem, breadcrumb)}</li>"
                end
              end

              html << '    </ol>'
              html << '  </div>'
              html << '</div>'
              html.html_safe

            else
              raise "Breadcrumbs-rails: unknown format '#{format.to_s}'"
          end

        end
      end


      private


      def breadcrumbs_name_or_link(breadcrumbs_gem, breadcrumb)
        return '' if breadcrumb[:name].to_s.blank?

        name = (breadcrumbs_gem[:localize] ? I18n.t(breadcrumb[:name]) : breadcrumb[:name])
        name = CGI::escapeHTML(name) unless breadcrumb[:html_safe] # escape name as we call html_safe

        if breadcrumb[:path].to_s.blank?
          name.html_safe
        else
          url = Rails.application.routes.url_helpers.send(breadcrumb[:path].to_s, breadcrumb[:params])
          link_to(name.html_safe, url)
        end
      end


    end
    # -----------------------------------------------------------


  end
end
