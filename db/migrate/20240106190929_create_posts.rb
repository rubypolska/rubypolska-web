# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string   :thumbnail
      t.string   :title
      t.text     :body
      t.string   :tags

      t.timestamps
    end
  end
end
