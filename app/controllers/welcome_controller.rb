class WelcomeController < ApplicationController
  def index
    @rentals = current_user.rentals.where(return_date: nil)
  end
end
