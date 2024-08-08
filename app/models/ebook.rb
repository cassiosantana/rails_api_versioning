# frozen_string_literal: true

class Ebook < ApplicationRecord
  validates :title, :author, presence: true
  validates :title, length: { minimum: 5, maximum: 100 }
end
