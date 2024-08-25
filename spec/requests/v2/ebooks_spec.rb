# frozen_string_literal: true

require "rails_helper"

RSpec.describe "V2::Ebooks", type: :request do
  let!(:ebooks) do
    3.times.map do
      Ebook.create!(
        title: FFaker::Book.title,
        author: FFaker::Book.author,
        genre: FFaker::Book.genre,
        isbn13: FFaker::Book.isbn,
        description: FFaker::Lorem.paragraph,
        publisher: FFaker::Company.name
      )
    end
  end

  describe "GET /v2/ebooks" do
    it "returns a list of ebooks correctly" do
      get v2_ebooks_path

      expect(response).to have_http_status(:ok)
      expect(json_response["data"].size).to eq(3)
    end
  end

  describe "GET /v2/ebooks/:id" do
    context "when ebook exists" do
      let(:ebook) { Ebook.first }

      it "returns a ebook correctly" do
        get v2_ebook_path(ebook)

        expect(response).to have_http_status :ok
        expect(json_response["data"]).to include(
          "id" => ebook.id.to_s,
          "type" => "ebooks",
          "attributes" => hash_including(
            "title" => ebook.title,
            "author" => ebook.author,
            "description" => ebook.description,
            "genre" => ebook.genre,
            "isbn" => ebook.isbn13,
            "publisher" => ebook.publisher,
            "created_at" => be_present,
            "updated_at" => be_present
          )
        )
        expect(json_response["data"]["attributes"]["created_at"].to_date).to eq(ebook.created_at.to_date)
        expect(json_response["data"]["attributes"]["updated_at"].to_date).to eq(ebook.updated_at.to_date)
      end
    end

    context "when the ebook does not exist" do
      it "show error message" do
        get v2_ebook_path(111)

        expect(response).to have_http_status :not_found

        expect(json_response["errors"]).to include(
          hash_including(
            "status" => "404",
            "source" => { "pointer" => "/data/id" },
            "title" => "Not Found",
            "detail" => "Couldn't find Ebook with 'id'=111"
          )
        )
      end
    end
  end

  describe "POST /v2/ebooks" do
    let(:valid_attributes) do
      {
        data: {
          type: :ebooks,
          attributes: {
            title: FFaker::Book.title,
            author: FFaker::Book.author,
            genre: FFaker::Book.genre,
            isbn: FFaker::Book.isbn,
            description: FFaker::Lorem.paragraph,
            publisher: FFaker::Company.name
          }
        }
      }
    end

    let(:invalid_attributes) do
      {
        data: {
          type: :ebooks,
          attributes: {
            author: FFaker::Book.author,
            genre: FFaker::Book.genre,
            isbn: FFaker::Book.isbn,
            description: FFaker::Lorem.paragraph,
            publisher: FFaker::Company.name
          }
        }
      }
    end

    context "when attributes are valid" do
      it "creates a new ebook" do
        post v2_ebooks_path, params: valid_attributes

        expect(response).to have_http_status :created
        expect(json_response["data"]).to include(
          "id" => be_present,
          "type" => "ebooks",
          "attributes" => hash_including(
            "title" => be_present,
            "description" => be_present,
            "author" => be_present,
            "genre" => be_present,
            "isbn" => be_present,
            "publisher" => be_present,
            "created_at" => be_present,
            "updated_at" => be_present
          )
        )
      end
    end

    context "when attributes are invalid" do
      it "does not create a new ebook" do
        post v2_ebooks_path, params: invalid_attributes

        expect(response).to have_http_status :unprocessable_entity
        expect(json_response["errors"].size).to eq(2)
        expect(json_response["errors"]).to include(
          hash_including(
            "status" => "422",
            "source" => { "pointer" => "/data/attributes/title" },
            "title" => "Invalid Attribute",
            "detail" => "can't be blank"
          ),
          hash_including(
            "status" => "422",
            "source" => { "pointer" => "/data/attributes/title" },
            "title" => "Invalid Attribute",
            "detail" => "is too short (minimum is 5 characters)"
          )
        )
      end
    end
  end
end
