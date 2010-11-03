class SessionsController < ApplicationController
  Sign_in_title = "Sign in"
  def new
    @title = Sign_in_title
  end

  def create
    u = User.authenticate(params[:session][:email],
                          params[:session][:password])
    if u.nil?
      #show error page
      flash.now[:error] = "Invalid email/password combination"
      @title = Sign_in_title
      render 'new'
    else
      #log the motherfucker in
    end
  end

  def destroy
    
  end
end
