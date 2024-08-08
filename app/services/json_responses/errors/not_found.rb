# frozen_string_literal: true

module JsonResponses
  module Errors
    class NotFound < BaseService
      def initialize(resource_name)
        @resource_name = resource_name
        super
      end

      def call
        {
          errors: [
            {
              status: "404",
              source: { pointer: "/data/id" },
              title: "Not Found",
              detail: "The #{@resource_name} requested is not available."
            }
          ]
        }
      end
    end
  end
end
