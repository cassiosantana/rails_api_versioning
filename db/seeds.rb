# frozen_string_literal: true

require "ffaker"

Ebook.destroy_all

5.times do
  Ebook.create!(
    title: FFaker::Book.title,
    author: FFaker::Book.author,
    genre: FFaker::Book.genre,
    isbn13: FFaker::Book.isbn,
    description: FFaker::Lorem.paragraph
  )
end
