# frozen_string_literal: true

class AddPublisherToEbooks < ActiveRecord::Migration[7.1]
  def change
    add_column :ebooks, :publisher, :string
  end
end
