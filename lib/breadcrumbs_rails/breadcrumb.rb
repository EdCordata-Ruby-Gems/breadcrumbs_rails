module BreadcrumbsRails
  class Breadcrumb


    attr_accessor :name,     :name_string,
                  :path,     :path_string,
                  :localize, :locale


    def initialize(name_string: nil, path_string: nil, localize: nil, locale: nil)
      @locale      = locale   || 'en'
      @localize    = localize || false

      @name_string = name_string
      @name        = generate_name

      @path_string = path_string
      @path        = generate_path
    end


    private


    def generate_name
      if @localize
        ::I18n.t(@name_string, locale: @locale, default: @name_string)
      else
        @name_string
      end
    end


    def generate_path
      url_helpers = ::Rails.application.routes.url_helpers

      if url_helpers.methods.include?(@path_string.to_s.to_sym)
        url_helpers.send(@path_string)
      else
        @path_string
      end
    end


  end
end
