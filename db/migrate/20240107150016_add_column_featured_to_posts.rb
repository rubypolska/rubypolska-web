# frozen_string_literal: true

class AddColumnFeaturedToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :featured, :boolean, default: false
  end
end
