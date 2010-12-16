class SessionsController < ApplicationController
  Sign_in_title = "Sign in"
  def new
    redirect_to users_path if signed_in?
    @title = Sign_in_title
  end

  def create
    redirect_to users_path if signed_in?
    user = User.authenticate(params[:session][:email],
                          params[:session][:password])
    if user.nil?
      #show error page
      flash.now[:error] = "Invalid email/password combination"
      @title = Sign_in_title
      render 'new'
    else
      #log the motherfucker in
      sign_in user
      redirect_back_or user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
