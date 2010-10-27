class UsersController < ApplicationController
  def new
    @title = "Sign up"
  end
  
  def show
    @title = "My Account"
    @user = User.find(params[:id])
  end

end
