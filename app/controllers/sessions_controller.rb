class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page if the account is activated.
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        return redirect_back_or user
      end
      message = "Account not activated. "
      message += "Check your email for the activation link."
      flash[:warning] = message
      return redirect_to root_url
    end
    # Create an error message.
    flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
