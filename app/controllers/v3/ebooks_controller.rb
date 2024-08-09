# frozen_string_literal: true

module V3
  class EbooksController < Base::EbooksController
    def index
      @ebooks = Ebook.page(params[:page]).per(5)
      render json: JsonResponses::Ebooks::Response.call(self.class.name, @ebooks)
    end

    private

    def ebook_params
      super.merge(params.require(:data).require(:attributes).permit(:publisher))
    end
  end
end
