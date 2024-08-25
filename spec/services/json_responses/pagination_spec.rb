# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonResponses::Pagination do
  let(:current_page) { 2 }
  let(:next_page) { 3 }
  let(:prev_page) { 1 }
  let(:total_pages) { 3 }
  let(:total_count) { 15 }

  let(:resource) do
    double(
      "PaginatedResource",
      current_page:,
      next_page:,
      prev_page:,
      total_pages:,
      total_count:
    )
  end

  subject { described_class.call(resource) }

  describe "#call" do
    it "returns the correct pagination structure" do
      expect(subject).to eq(
        {
          pagination: {
            current_page:,
            next_page:,
            prev_page:,
            total_pages:,
            total_count:
          }
        }
      )
    end
  end
end
