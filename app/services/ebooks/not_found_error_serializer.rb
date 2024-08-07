# frozen_string_literal: true

module Ebooks
  class NotFoundErrorSerializer < Ebooks::Base
    def call
      {
        errors: [
          {
            status: "404",
            source: { pointer: "/data/id" },
            title: "Not Found",
            detail: "Ebook not found"
          }
        ]
      }
    end
  end
end
