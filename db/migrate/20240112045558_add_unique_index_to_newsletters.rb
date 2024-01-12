# frozen_string_literal: true

class AddUniqueIndexToNewsletters < ActiveRecord::Migration[5.2]
  def change
    add_index :newsletters, :email, unique: true
    add_index :newsletters, :token, unique: true
  end
end
