class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :manufacturer
      t.datetime :publication_date
      t.string :isbn
      t.string :code
      t.binary :image
      t.references :Rental, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
