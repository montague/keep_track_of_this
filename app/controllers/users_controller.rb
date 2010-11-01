class UsersController < ApplicationController
  Sign_up_title = "Sign up"

  def new
    @title = Sign_up_title
    @user = User.new
  end
  
  def show
    @title = "My Account"
    @user = User.find(params[:id])
  end

  def index
      redirect_to :action => 'new'
    end

  def create
    @user = User.new(params[:user])
    @user.uuid = UUID.new.generate
    if @user.save
      #stuff
    else
      @title =  Sign_up_title
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

end
