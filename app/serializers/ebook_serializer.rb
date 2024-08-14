# frozen_string_literal: true

class EbookSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :author, :genre, :isbn13, :created_at, :updated_at
end
