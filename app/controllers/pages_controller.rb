class PagesController < ApplicationController
  
  def home
    @title = "Home"
    if signed_in?
      @item = Item.new
    else
      redirect_to '/signin'
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def bookmarklet
    @title = "Your Bookmarklet"
    if !signed_in?
      generic_error
      redirect_to '/signin'
    end
  end

  private
  
  def generic_error(error_message = nil)
    flash[:error] = error_message.nil? ? "you need to be signed in to do that" : error_message
  end
  
end
