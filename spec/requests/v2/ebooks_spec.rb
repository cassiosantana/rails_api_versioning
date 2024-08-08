# frozen_string_literal: true

require "rails_helper"

RSpec.describe "V2::Ebooks", type: :request do
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
        expect(json_response["data"]["id"]).to eq(ebook.id.to_s)
        expect(json_response["data"]["type"]).to eq("ebooks")
        expect(json_response["data"]["attributes"]["title"]).to eq(ebook.title)
        expect(json_response["data"]["attributes"]["description"]).to eq(ebook.description)
        expect(json_response["data"]["attributes"]["author"]).to eq(ebook.author)
        expect(json_response["data"]["attributes"]["genre"]).to eq(ebook.genre)
        expect(json_response["data"]["attributes"]["isbn"]).to eq(ebook.isbn)
        expect(json_response["data"]["attributes"]["publisher"]).to eq(ebook.publisher)
        expect(json_response["data"]["attributes"]["created_at"].to_date).to eq(ebook.created_at.to_date)
        expect(json_response["data"]["attributes"]["updated_at"].to_date).to eq(ebook.updated_at.to_date)
      end
    end

    context "when the ebook does not exist" do
      it "show error message" do
        get v2_ebook_path(111)

        expect(response).to have_http_status :not_found
        expect(json_response["errors"][0]["status"]).to eq("404")
        expect(json_response["errors"][0]["source"]["pointer"]).to eq("/data/id")
        expect(json_response["errors"][0]["title"]).to eq("Not Found")
        expect(json_response["errors"][0]["detail"]).to eq("Ebook not found")
      end
    end
  end

  describe "POST /v2/ebooks" do
    let(:attributes) do
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

    context "when the ebook can be created" do
      it "creates a new ebook" do
        post v2_ebooks_path, params: attributes

        expect(response).to have_http_status :created
        expect(json_response["data"]["id"]).to be_present
        expect(json_response["data"]["type"]).to eq("ebooks")
        expect(json_response["data"]["attributes"]["title"]).to be_present
        expect(json_response["data"]["attributes"]["description"]).to be_present
        expect(json_response["data"]["attributes"]["author"]).to be_present
        expect(json_response["data"]["attributes"]["genre"]).to be_present
        expect(json_response["data"]["attributes"]["isbn"]).to be_present
        expect(json_response["data"]["attributes"]["created_at"]).to be_present
        expect(json_response["data"]["attributes"]["updated_at"]).to be_present
        expect(json_response["data"]["attributes"]["publisher"]).to be_present
      end
    end

    context "when the ebook can't be created" do
      before do
        allow_any_instance_of(Ebook).to receive(:save).and_return(false)
      end

      it "does not create a new ebook" do
        post v2_ebooks_path, params: attributes

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
