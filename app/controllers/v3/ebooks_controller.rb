# frozen_string_literal: true

module V3
  class EbooksController < Base::EbooksController
    def index
      @ebooks = Ebook.page(params[:page]).per(5)

      ebooks = JsonResponses::Ebooks::Response.call(self.class.name, @ebooks)
      pagination = JsonResponses::Pagination.call(@ebooks)
      links = JsonResponses::Links.call(@ebooks, request)

      render json: {
        data: ebooks[:data],
        meta: pagination,
        links:
      }
    end

    private

    def ebook_params
      super.merge(params.require(:data).require(:attributes).permit(:publisher))
    end
  end
end
