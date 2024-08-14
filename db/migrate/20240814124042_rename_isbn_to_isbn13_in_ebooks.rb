# frozen_string_literal: true

class RenameIsbnToIsbn13InEbooks < ActiveRecord::Migration[7.1]
  def change
    rename_column :ebooks, :isbn, :isbn13
  end
end
