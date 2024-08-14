# frozen_string_literal: true

module V1
  class EbooksController < ApplicationController
    def index
      @ebooks = Ebook.all
      render json: V1::EbooksSerializer.new(@ebooks).serializable_hash
    end

    def show
      @ebook = Ebook.find(params[:id])
      render json: V1::EbooksSerializer.new(@ebook).serializable_hash
    end

    def create
      @ebook = Ebook.new(ebook_params)

      if @ebook.save
        render json: V1::EbooksSerializer.new(@ebook).serializable_hash, status: :created
      else
        render json: JsonResponses::Errors::Validation.call(@ebook.errors), status: :unprocessable_entity
      end
    end

    private

    def ebook_params
      params.require(:data).require(:attributes).permit(:title, :description, :author, :genre, :isbn)
    end
  end
end
