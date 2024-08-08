# frozen_string_literal: true

module Base
  class EbooksController < ApplicationController
    def index
      @ebooks = Ebook.all
      render json: Ebooks::ResponseSerializer.call(self.class.name, @ebooks)
    end

    def show
      @ebook = Ebook.find(params[:id])
      render json: Ebooks::ResponseSerializer.call(self.class.name, @ebook)
    rescue ActiveRecord::RecordNotFound
      render json: Ebooks::NotFoundErrorSerializer.call, status: :not_found
    end

    def create
      @ebook = Ebook.new(ebook_params)

      if @ebook.save
        render json: Ebooks::ResponseSerializer.call(self.class.name, @ebook),
               status: :created
      else
        render json: Ebooks::ValidationErrorsSerializer.call(@ebook.errors), status: :unprocessable_entity
      end
    end

    private

    def ebook_params
      params.require(:data).require(:attributes).permit(:title, :description, :author, :genre, :isbn)
    end
  end
end
