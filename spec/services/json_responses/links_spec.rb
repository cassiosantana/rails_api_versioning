# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonResponses::Links do
  let(:request) do
    double(
      "request",
      path: "/ebooks",
      base_url: "http://localhost:3000"
    )
  end

  let(:resource) do
    double(
      "PaginatedResource",
      current_page: 2,
      next_page: 3,
      prev_page: 1,
      total_pages: 3,
      total_count: 15
    )
  end

  subject { described_class.call(resource, request) }

  describe "#call" do
    context "when next and prev pages are present" do
      it "returns the correct links" do
        expect(subject).to eq(
          {
            self: { href: "http://localhost:3000/ebooks?page=2" },
            next: { href: "http://localhost:3000/ebooks?page=3" },
            prev: { href: "http://localhost:3000/ebooks?page=1" },
            first: { href: "http://localhost:3000/ebooks?page=1" },
            last: { href: "http://localhost:3000/ebooks?page=3" }
          }
        )
      end
    end

    context "when next_page is nil" do
      before { allow(resource).to receive(:next_page).and_return(nil) }

      it "excludes the next link" do
        expect(subject).to eq(
          {
            self: { href: "http://localhost:3000/ebooks?page=2" },
            next: nil,
            prev: { href: "http://localhost:3000/ebooks?page=1" },
            first: { href: "http://localhost:3000/ebooks?page=1" },
            last: { href: "http://localhost:3000/ebooks?page=3" }
          }
        )
      end
    end

    context "when prev_page is nil" do
      before { allow(resource).to receive(:prev_page).and_return(nil) }

      it "excludes the prev link" do
        expect(subject).to eq(
          {
            self: { href: "http://localhost:3000/ebooks?page=2" },
            next: { href: "http://localhost:3000/ebooks?page=3" },
            prev: nil,
            first: { href: "http://localhost:3000/ebooks?page=1" },
            last: { href: "http://localhost:3000/ebooks?page=3" }
          }
        )
      end
    end
  end
end
