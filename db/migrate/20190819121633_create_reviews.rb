# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[5.2]
  def up
    create_table :reviews do |t|
      t.text 'text'
      t.string 'reviewer_name', limit: 40
      t.integer 'rating'
      t.integer 'restaurant_id'
      t.timestamps
    end
  end

  def down
    drop_table :reviews
  end
end
