class CreateRestaurants < ActiveRecord::Migration[5.2]
  def up
    create_table :restaurants do |t|
      t.column "name", :string, limit: 40
      t.column "cuisine", :string, limit: 20
      t.column "is_10_bis", :boolean
      t.column "address", :string, limit: 60
      t.column "max_delivery_time_in_minutes", :integer
      t.timestamps
    end
  end

  def down
    drop_table :restaurants
  end
end
