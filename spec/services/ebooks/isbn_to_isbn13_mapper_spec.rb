# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ebooks::IsbnToIsbn13Mapper, type: :service do
  describe "#call" do
    let(:params) do
      {
        data: {
          attributes: {
            isbn: "1234567890"
          }
        }
      }
    end

    subject { described_class.call(params) }

    it "converts isbn to isbn13" do
      subject
      expect(params[:data][:attributes][:isbn13]).to eq("1234567890")
      expect(params[:data][:attributes][:isbn]).to be_nil
    end

    context "when isbn is not present" do
      let(:params) do
        {
          data: {
            attributes: {}
          }
        }
      end

      it "does not add isbn13" do
        subject
        expect(params[:data][:attributes][:isbn13]).to be_nil
      end
    end
  end
end
