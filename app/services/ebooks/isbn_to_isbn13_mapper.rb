# frozen_string_literal: true

module Ebooks
  class IsbnToIsbn13Mapper < ApplicationService
    def initialize(params)
      @params = params
      super
    end

    def call
      map_isbn_to_isbn13
    end

    private

    def map_isbn_to_isbn13
      return unless (isbn = @params[:data][:attributes].delete(:isbn))

      @params[:data][:attributes][:isbn13] = isbn
    end
  end
end
