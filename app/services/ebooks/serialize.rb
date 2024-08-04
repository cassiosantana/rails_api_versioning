# frozen_string_literal: true

module Ebooks
  class Serialize
    def self.call(controller_name, resource)
      new(controller_name, resource).call
    end

    def initialize(controller_name, resource)
      @controller_name = controller_name
      @resource = resource
    end

    def call
      serializer = select_serializer
      serializer.new(@resource).serializable_hash.to_json
    end

    private

    def select_serializer
      case @controller_name
      when "V1::EbooksController"
        V1::EbooksSerializer
      when "V2::EbooksController"
        V2::EbooksSerializer
      else
        raise "Serializer not found for controller_name: #{@controller_name}"
      end
    end
  end
end
