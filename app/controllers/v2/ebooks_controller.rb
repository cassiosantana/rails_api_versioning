# frozen_string_literal: true

module V2
  class EbooksController < Base::EbooksController
    private

    def ebook_params
      super.merge(params.require(:ebook).permit(:publisher))
    end
  end
end
