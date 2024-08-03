# frozen_string_literal: true

module V2
  class EbookSerializer
    include JSONAPI::Serializer
    attributes :id, :title, :description, :author, :genre, :isbn, :publisher
  end
end
