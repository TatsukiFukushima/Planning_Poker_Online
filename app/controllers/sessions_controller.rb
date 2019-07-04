class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # Websocketサーバーからアクセスするため、Cookieにcurrent_userを保存。
      cookies.encrypted[:user_id] = user.id
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレスかパスワードが違うみたいだぞ'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
