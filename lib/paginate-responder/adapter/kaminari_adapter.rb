module PaginateResponder::Adapter

  # Pagination adapter for kaminari.
  #
  class KaminariAdapter < Base

    def suitable?
      resource.respond_to?(:page) and not resource.respond_to?(:paginate)
    end

    def paginated?
      resource.respond_to?(:limit_value) &&
      resource.respond_to?(:offset_value) &&
      resource.respond_to?(:total_count) &&
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
      resource.total_count
    end
  end

  if defined?(:Kaminari)
    ::PaginateResponder::Paginator.register KaminariAdapter
  end
end
