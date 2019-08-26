class CreateReviews < ActiveRecord::Migration[5.2]
  def up
    create_table :reviews do |t|
      t.column "text", :text
      t.column "reviewer_name", :string, limit: 40
      t.column "rating", :integer
      t.column "restaurant_id", :integer
      t.timestamps
    end
  end

  def down
    drop_table :reviews
  end
end
