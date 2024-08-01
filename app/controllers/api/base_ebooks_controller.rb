# frozen_string_literal: true

module Api
  class BaseEbooksController < ApplicationController
    def index
      @ebooks = Ebook.all
      render json: @ebooks
    end

    def show
      @ebook = Ebook.find(params[:id])
      render json: @ebook
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Ebook not found" }, status: :not_found
    end

    def create
      @ebook = Ebook.new(ebook_params)

      if @ebook.save
        render json: @ebook, status: :created
      else
        render json: @ebook.errors, status: :unprocessable_entity
      end
    end

    private

    def ebook_params
      params.require(:ebook).permit(:title, :description, :author, :genre, :isbn)
    end
  end
end
