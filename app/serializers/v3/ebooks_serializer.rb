# frozen_string_literal: true

module V3
  class EbooksSerializer < EbookSerializer
    include JSONAPI::Serializer
    attributes :publisher
  end
end
