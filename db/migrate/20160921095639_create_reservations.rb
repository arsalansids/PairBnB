class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id, null: false
      t.integer :listing_id, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps null: false
    end
  end
end
