# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonResponses::Errors::Validation do
  describe "#call" do
    let(:messages) do
      {
        title: ["can't be blank", "is too short (minimum is 5 characters)"],
        author: ["can't be blank"]
      }
    end

    let(:ebook_errors) do
      instance_double(ActiveModel::Errors, messages:)
    end

    subject { described_class.call(ebook_errors) }

    it "returns the correct error structure" do
      expected_response = {
        errors: [
          {
            status: "422",
            source: { pointer: "/data/attributes/title" },
            title: "Invalid Attribute",
            detail: "can't be blank"
          },
          {
            status: "422",
            source: { pointer: "/data/attributes/title" },
            title: "Invalid Attribute",
            detail: "is too short (minimum is 5 characters)"
          },
          {
            status: "422",
            source: { pointer: "/data/attributes/author" },
            title: "Invalid Attribute",
            detail: "can't be blank"
          }
        ]
      }

      expect(subject).to eq(expected_response)
    end
  end
end
