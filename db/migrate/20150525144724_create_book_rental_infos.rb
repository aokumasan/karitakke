class CreateBookRentalInfos < ActiveRecord::Migration
  def change
    create_table :book_rental_infos do |t|
      t.integer :rental_count
      t.integer :last_rental_id
      t.string :last_rental_name
      t.integer :now_rental_id
      t.string :now_rental_name
      t.references :Book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
