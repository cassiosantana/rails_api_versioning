# frozen_string_literal: true

module V2
  class EbooksSerializer
    include JSONAPI::Serializer
    attributes :title, :description, :author, :genre, :isbn, :publisher, :created_at, :updated_at
  end
end
