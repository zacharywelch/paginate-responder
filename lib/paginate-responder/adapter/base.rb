module PaginateResponder::Adapter
  class Base
    attr_reader :resource

    def initialize(resource)
      @resource = resource
    end

    # If pagination for current resource is supported.
    #
    def suitable?
      false
    end

    # If current resource is paginated.
    def paginated?
      false
    end

    # Return number of current page.
    #
    def page
      nil
    end

    # Return value for items per page.
    #
    def per_page
      nil
    end

    # Return number of total pages for current resource.
    #
    def total_pages
      nil
    end

    # Return number of total items.
    #
    def total_count
      nil
    end
  end
end
