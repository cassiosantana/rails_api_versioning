# frozen_string_literal: true

module JsonResponses
  module Errors
    class NotFound < ApplicationService
      def initialize(exeption)
        @exeption = exeption
        super
      end

      def call
        {
          errors: [
            {
              status: "404",
              source: { pointer: "/data/#{@exeption.primary_key}" },
              title: "Not Found",
              detail: @exeption.message
            }
          ]
        }
      end
    end
  end
end
