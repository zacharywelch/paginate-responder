module PaginateResponder::Adapter

  # Pagination adapter for will_paginate.
  #
  class PaginateAdapter < Base

    def suitable?
      resource.respond_to?(:paginate)
    end

    def paginated?
      resource.respond_to?(:limit_value) &&
      resource.respond_to?(:offset_value) &&
      resource.respond_to?(:total_entries) &&
      resource.respond_to?(:total_pages)
    end

    def page
      (resource.offset_value / resource.limit_value).round + 1
    end

    def per_page
      resource.limit_value
    end

    def total_pages
      resource.total_pages
    end

    def total_count
      resource.total_entries
    end
  end

  if defined?(:WillPaginate)
    ::PaginateResponder::Paginator.register PaginateAdapter
  end
end
