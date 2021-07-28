module BreadcrumbsRails
  class Breadcrumbs

    attr_accessor :breadcrumbs,
                  :scope,    :format,
                  :title,    :title_string,
                  :localize, :locale

    def initialize(breadcrumbs: [], title_string: nil, scope: nil, format: nil, localize: nil, locale: nil)
      @breadcrumbs = breadcrumbs || []
      @format      = format || 'html'
      @scope       = scope

      @title_string = title_string
      @title        = generate_title

      @localize = localize || false
      @locale   = locale   || 'en'
    end

    def title_string=(title_string)
      @title_string = title_string
      @title        = generate_title
    end

    private

    def generate_title
      if @localize
        ::I18n.t(@title_string, locale: @locale, default: @title_string)
      else
        @title_string
      end
    end

  end
end
