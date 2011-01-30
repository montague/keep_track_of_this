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
    else
      @bookmarklet = get_bookmarklet
    end
  end

  def get_bookmarklet
    "javascript:(function(){if(window._ktt===undefined){window._ktt_identifier='#{current_user.uuid}';if(console)console.log('requesting boostrap');var s=document.createElement('script'),head=document.getElementsByTagName('head')[0];s.src='#{request.url.gsub!(/bookmarklet/,'bootstrap')}?'+new Date().getTime();head.appendChild(s);}
      else{if(console)console.log('ktt detected. no request made');window._ktt.go();}})();"
  end

  private
  
  def generic_error(error_message = nil)
    flash[:error] = error_message.nil? ? "you need to be signed in to do that" : error_message
  end
  
end
