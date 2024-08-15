# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :map_isbn_to_isbn13, only: :create
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def map_isbn_to_isbn13
    return unless params[:data][:attributes][:isbn].present?

    params[:data][:attributes][:isbn13] = params[:data][:attributes].delete(:isbn)
  end

  def not_found(exception)
    render json: JsonResponses::Errors::NotFound.call(exception), status: :not_found
  end
end
