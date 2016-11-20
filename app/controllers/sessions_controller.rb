class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        log_in(user)
        flash[:success] = "You have successfully logged in"
        redirect_to user_path(user)
    else
        flash.now[:danger] = "There was something wrong with your login information"
        render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

end
