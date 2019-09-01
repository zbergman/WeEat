# frozen_string_literal: true

class CreateRestaurants < ActiveRecord::Migration[5.2]
  def up
    create_table :restaurants do |t|
      t.string 'name', limit: 40
      t.string 'cuisine', limit: 20
      t.boolean 'is_10_bis'
      t.string 'address', limit: 60
      t.integer 'max_delivery_time_in_minutes'
      t.timestamps
    end
  end

  def down
    drop_table :restaurants
  end
end
