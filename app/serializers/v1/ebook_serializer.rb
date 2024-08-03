# frozen_string_literal: true

module V1
  class EbookSerializer
    include JSONAPI::Serializer
    attributes :id, :title, :description, :author, :genre, :isbn
  end
end
