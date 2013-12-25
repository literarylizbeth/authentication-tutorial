class SessionsController < ApplicationController

  skip_before_action :confirm_signed_in

  def new
    redirect_to current_user if signed_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to params[:session].fetch(:destination, root_url)
    else
      flash.now[:danger] = "Invalid username and/or password."
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
  
end
