class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]

  Sign_up_title = "Sign up"

  def new
    redirect_to users_path if signed_in?
    @title = Sign_up_title
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.nil? ? "My Account" : @user.email
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def create
    redirect_to users_path if signed_in?
    @user = User.new(params[:user])
    @user.uuid = UUID.new.generate
    if @user.save
      sign_in @user
      flash[:success] = "your account has been created"
      redirect_to @user
    else
      @title =  Sign_up_title
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

  def destroy
    id = params[:id]
    User.find(id).destroy if id != current_user.id
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
