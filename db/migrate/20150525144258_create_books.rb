class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :manufacturer
      t.date :publication_date
      t.string :isbn
      t.string :code
      t.string :image_url
      t.binary :image

      t.timestamps null: false
    end
  end
end
