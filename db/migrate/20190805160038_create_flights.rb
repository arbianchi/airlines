class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.string :origin
      t.string :destination
      t.timestamp :departure_time
      t.float :duration
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
