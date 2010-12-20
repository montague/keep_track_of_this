class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @item = Item.new
    else
      redirect_to '/signin' unless signed_in?
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

end
