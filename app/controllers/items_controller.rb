class ItemsController < ApplicationController
  #right now, this filter applies to all actions. 
  #if we were to add an action that anyone could access,
  #we'd have to specify that the before_filter only applies
  #to those actions we'd like to restrict, like so:
  #before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authenticate

  def create
    @item = current_user.items.build(params[:item])
    if @item.save
      flash[:success] = "Item created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
    
  end
end