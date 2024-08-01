# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::Ebooks", type: :request do
  let!(:ebooks) do
    3.times.map do
      Ebook.create!(
        title: FFaker::Book.title,
        author: FFaker::Book.author,
        genre: FFaker::Book.genre,
        isbn: FFaker::Book.isbn,
        description: FFaker::Lorem.paragraph,
        publisher: FFaker::Company.name
      )
    end
  end

  describe "GET /api/v2/ebooks/:id" do
    context "when ebook exists" do
      let(:ebook) { ebooks.first }

      it "returns a ebook correctly" do
        get api_v2_ebook_path(ebook)

        expect(response).to have_http_status :ok
        expect(json_response["publisher"]).to eq(ebook.publisher)
      end
    end
  end

  describe "POST /api/v2/ebooks" do
    let(:attributes) do
      {
        ebook: {
          title: FFaker::Book.title,
          author: FFaker::Book.author,
          genre: FFaker::Book.genre,
          isbn: FFaker::Book.isbn,
          description: FFaker::Lorem.paragraph,
          publisher: FFaker::Company.name
        }
      }
    end

    context "when the ebook can be created" do
      it "creates a new ebook" do
        post api_v2_ebooks_path, params: attributes

        expect(response).to have_http_status :created
        expect(json_response["publisher"]).to be_present
      end
    end
  end
end
