# frozen_string_literal: true

module V2
  class EbooksSerializer < EbookSerializer
    include JSONAPI::Serializer
    attributes :publisher
  end
end
