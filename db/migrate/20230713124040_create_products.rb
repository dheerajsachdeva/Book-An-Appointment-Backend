# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.string :description
      t.string :model
      t.string :engine
      t.integer :price
      t.integer :mileage

      t.timestamps
    end
  end
end
