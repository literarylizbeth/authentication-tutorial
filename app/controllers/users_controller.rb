class UsersController < ApplicationController

  skip_before_action :confirm_signed_in, only: [:new, :create]
  before_action :confirm_correct_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    sign_out
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit!
    end

end
