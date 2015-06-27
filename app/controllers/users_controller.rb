class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params[:user].permit(:role)
    end

    def set_book
      @user = User.find(params[:id])
    end
end
