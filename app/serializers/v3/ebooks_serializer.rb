# frozen_string_literal: true

module V3
  class EbooksSerializer
    include JSONAPI::Serializer

    attributes :title, :description, :author, :genre, :publisher, :isbn13, :created_at, :updated_at
  end
end
