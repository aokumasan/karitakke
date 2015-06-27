class LogsController < ApplicationController
  load_and_authorize_resource :Rental

  def index
    @logs = Rental.all
  end

end
