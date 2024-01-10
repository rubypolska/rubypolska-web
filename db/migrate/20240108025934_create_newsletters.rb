# frozen_string_literal: true

class CreateNewsletters < ActiveRecord::Migration[5.2]
  def change
    create_table :newsletters do |t|
      t.string   :name
      t.string   :email
      t.string   :token
      t.integer  :status
      t.datetime :cancel_at

      t.timestamps
    end
  end
end
