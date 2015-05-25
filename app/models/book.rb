class Book < ActiveRecord::Base
  has_one :rental
  has_one :book_rental_info

  validates :title, :author, :manufacturer, :publication_date, :isbn, :code, presence: true

  validates :code, uniqueness: true

end
