class UsersController < ApplicationController
  before_filter :authenticate_user!

  #instance variables in the controller become available to corresponding view
  # e.g. for users#index  in views/users/index

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
