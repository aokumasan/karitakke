class WelcomeController < ApplicationController
  def index
    @rentals = current_user.rentals.all
  end
end
