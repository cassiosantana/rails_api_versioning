# frozen_string_literal: true

module Base
  class EbooksController < ApplicationController
    def index
      @ebooks = Ebook.all
      render json: serialize(@ebooks)
    end

    def show
      @ebook = Ebook.find(params[:id])
      render json: serialize(@ebook)
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Ebook not found" }, status: :not_found
    end

    def create
      @ebook = Ebook.new(ebook_params)

      if @ebook.save
        render json: serialize(@ebook),
               status: :created
      else
        render json: @ebook.errors, status: :unprocessable_entity
      end
    end

    private

    def ebook_params
      params.require(:ebook).permit(:title, :description, :author, :genre, :isbn)
    end

    def serialize(resource)
      Ebooks::Serialize.call(self.class.name, resource)
    end
  end
end
