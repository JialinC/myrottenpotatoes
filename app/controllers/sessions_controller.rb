class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_action :set_current_user#, only: [:create]

  def create
    puts 'called'
    auth=request.env["omniauth.auth"]
    #byebug
    user = Moviegoer.find_by(:provider => auth["provider"], :uid => auth["uid"]) ||
      Moviegoer.create_with_omniauth(auth)
    session[:user_id] = user.id
    puts user
    redirect_to movies_path
  end

  def destroy
    puts session[:user_id]
    session.delete(:user_id)
    puts 'logged out'
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end
end