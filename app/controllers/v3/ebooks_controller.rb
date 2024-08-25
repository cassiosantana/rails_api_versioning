# frozen_string_literal: true

module V3
  class EbooksController < ApplicationController
    def index
      @ebooks = Ebook.page(params[:page]).per(5)

      render json: {
        data: V3::EbooksSerializer.new(@ebooks).serializable_hash[:data],
        meta: JsonResponses::Pagination.call(@ebooks),
        links: JsonResponses::Links.call(@ebooks, request)
      }
    end

    def show
      @ebook = Ebook.find(params[:id])
      render json: V3::EbooksSerializer.new(@ebook).serializable_hash
    end

    def create
      @ebook = Ebook.new(ebook_params)

      if @ebook.save
        render json: V3::EbooksSerializer.new(@ebook).serializable_hash, status: :created
      else
        render json: JsonResponses::Errors::Validation.call(@ebook.errors), status: :unprocessable_entity
      end
    end

    private

    def ebook_params
      params.require(:data).require(:attributes).permit(:title, :description, :author, :genre, :isbn13, :publisher)
    end
  end
end
