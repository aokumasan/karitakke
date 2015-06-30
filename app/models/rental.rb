class Rental < ActiveRecord::Base
  belongs_to :user, inverse_of: :rentals
  belongs_to :book, inverse_of: :rentals
end
