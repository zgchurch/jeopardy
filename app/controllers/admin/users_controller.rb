class Admin::UsersController < ApplicationController
  before_filter :authorize_admin!

  def index
    @users = User.active.order('username')
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if params[:user][:password].blank? || params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def history
    @user = User.find(params[:user_id])
  end
  
  def analyze
    @user = User.find(params[:user_id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    
    redirect_to admin_users_path
  end

  def authorize_admin!
    unless current_user.admin?
      redirect_to root_path, :alert => 'You do not have permission to view that page.'
    end
  end
end
