# frozen_string_literal: true

module V2
  class EbooksController < Base::EbooksController
    private

    def ebook_params
      super.merge(params.require(:data).require(:attributes).permit(:publisher))
    end
  end
end
