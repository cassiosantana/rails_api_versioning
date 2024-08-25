# frozen_string_literal: true

module JsonResponses
  class Links < ApplicationService
    def initialize(resource, request)
      @resource = resource
      @request = request
      super
    end

    def call
      {
        self: { href: url_for(page: @resource.current_page) },
        next: @resource.next_page ? { href: url_for(page: @resource.next_page) } : nil,
        prev: @resource.prev_page ? { href: url_for(page: @resource.prev_page) } : nil,
        first: { href: url_for(page: 1) },
        last: { href: url_for(page: @resource.total_pages) }
      }
    end

    def url_for(page:)
      "#{@request.base_url}#{@request.path}?page=#{page}"
    end
  end
end
