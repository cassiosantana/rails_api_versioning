# frozen_string_literal: true

module Api
  module V2
    class EbooksController < BaseEbooksController
      private

      def ebook_params
        params.require(:ebook).permit(:title, :description, :author, :genre, :isbn, :publisher)
      end
    end
  end
end
