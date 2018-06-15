class SessionsController < ApplicationController

  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # not @user because local var

    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:warning] = 'You have been logged out'
    render 'new'
  end
end