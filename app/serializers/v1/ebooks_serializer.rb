# frozen_string_literal: true

module V1
  class EbooksSerializer
    include JSONAPI::Serializer
    attributes :title, :description, :author, :genre, :isbn, :created_at, :updated_at
  end
end
