module PaginateResponder
  class Paginator
    extend Forwardable

    attr_reader :responder, :adapter, :resource

    def initialize(responder)
      @responder = responder
      @resource  = responder.resource
      @adapter   = find_adapter
    end

    def find_adapter
      return controller.pagination_adapter(resource) if controller.respond_to? :pagination_adapter

      self.class.adapters.each do |adapter_class|
        begin
          adapter_class.new(resource).tap do |adapter|
            return adapter if adapter.suitable?
          end
        rescue
          next
        end
      end
      Adapter::Base.new(resource)
    end

    def request; responder.request end
    def response; controller.response end
    def controller; responder.controller end

    def_delegators :@adapter, :paginated?, :page, :per_page, :total_pages, :total_count

    def paginate!
      headers! if paginated?

      resource
    end

    def headers!
      link! 'first', 1
      link! 'prev', page - 1    if page > 1
      link! 'next', page + 1    if total_pages && page < total_pages
      link! 'last', total_pages if total_pages

      response.headers["X-Total-Pages"] = total_pages.to_s if total_pages
      response.headers["X-Total-Count"] = total_count.to_s if total_count
      response.headers["X-Per-Page"]    = per_page.to_s
      response.headers["X-Page"]        = page.to_s
    end

    def link!(rel, page)
      response.link(controller.url_for(request.params.merge(:page => page)), :rel => rel)
    end


    class << self
      def adapters
        @adapters ||= []
      end

      def register(adapter)
        adapters << adapter
      end
    end
  end
end
