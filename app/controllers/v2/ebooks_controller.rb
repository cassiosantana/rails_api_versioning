# frozen_string_literal: true

module V2
  class EbooksController < ApplicationController
    def index
      @ebooks = Ebook.all
      render json: V2::EbooksSerializer.new(@ebooks).serializable_hash
    end

    def show
      @ebook = Ebook.find(params[:id])
      render json: V2::EbooksSerializer.new(@ebook).serializable_hash
    end

    def create
      @ebook = Ebook.new(ebook_params)

      if @ebook.save
        render json: V2::EbooksSerializer.new(@ebook).serializable_hash, status: :created
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
