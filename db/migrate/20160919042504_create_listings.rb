class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|

      t.string :title, null: false
      t.string :location, null: false
      t.string :home_type, null: false
      t.integer :price, null: false
      t.integer :num_of_people, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end


