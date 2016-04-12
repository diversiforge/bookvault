class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: admin_users_path }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params.reject {|k,v| k.include?('password') && v.blank?})
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_users_path }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @user.id == current_user.id
      respond_to do |format|
        format.html { redirect_to admin_users_url, alert: 'You cannot disable yourself.' }
        format.json { head 400 }
      end
    else
      @user.update_column(:active, false)
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: 'User was successfully disabled.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :active, :email, :password, :password_confirmation)
    end
end
