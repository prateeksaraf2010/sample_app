class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user

    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' #
      # Not quite right!
      render 'new'
    end
  end

  def current_user
    if session[:user_id]
      User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
