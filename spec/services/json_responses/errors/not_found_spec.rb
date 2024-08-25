# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonResponses::Errors::NotFound do
  describe "#call" do
    let(:exception) { instance_double(ActiveRecord::RecordNotFound, primary_key: "id", message: "Record not found") }
    subject { described_class.call(exception) }

    it "returns the correct error structure" do
      expected_response = {
        errors: [
          {
            status: "404",
            source: { pointer: "/data/id" },
            title: "Not Found",
            detail: "Record not found"
          }
        ]
      }

      expect(subject).to eq(expected_response)
    end
  end
end
