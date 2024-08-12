# frozen_string_literal: true

module JsonResponses
  module Ebooks
    class Response < BaseService
      def initialize(controller_name, resource)
        @controller_name = controller_name
        @resource = resource
        super
      end

      def call
        serializer = select_serializer
        serializer.new(@resource).serializable_hash
      end

      private

      def select_serializer
        case @controller_name
        when "V1::EbooksController"
          V1::EbooksSerializer
        when "V2::EbooksController"
          V2::EbooksSerializer
        when "V3::EbooksController"
          V3::EbooksSerializer
        else
          raise "Serializer not found for controller_name: #{@controller_name}"
        end
      end
    end
  end
end
