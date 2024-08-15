# frozen_string_literal: true

module V2
  class EbooksSerializer
    include JSONAPI::Serializer

    attributes :title, :description, :author, :genre, :publisher, :isbn, :created_at, :updated_at

    attribute :isbn do |ebook|
      ebook.isbn13.to_s
    end
  end
end
