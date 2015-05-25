class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.datetime :rental_date
      t.datetime :return_date
      t.string :user_name
      t.references :User, index: true, foreign_key: true
      t.references :Book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
