# frozen_string_literal: true

module Ebooks
  class ValidationErrorsSerializer < Ebooks::Base
    def initialize(errors)
      @errors = errors
      super
    end

    def call
      {
        errors: @errors.messages.flat_map do |attribute, messages|
          messages.map do |message|
            {
              status: "422",
              source: { pointer: "/data/attributes/#{attribute}" },
              title: "Invalid Attribute",
              detail: message
            }
          end
        end
      }
    end
  end
end
