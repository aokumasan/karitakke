class LogsController < ApplicationController

  def index
    @logs = Rental.all
  end

end
