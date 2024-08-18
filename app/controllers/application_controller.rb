# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :map_isbn_to_isbn13, only: :create
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def map_isbn_to_isbn13
    return unless isbn_present?

    Ebooks::IsbnToIsbn13Mapper.call(params)
  end

  def not_found(exception)
    render json: JsonResponses::Errors::NotFound.call(exception), status: :not_found
  end

  def isbn_present?
    params.dig(:data, :attributes, :isbn).present?
  end
end
