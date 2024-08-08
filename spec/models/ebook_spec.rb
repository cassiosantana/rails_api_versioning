# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ebook, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(100) }
    it { should validate_presence_of(:author) }
  end
end
