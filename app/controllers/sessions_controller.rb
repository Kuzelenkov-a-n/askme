class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to root_path, notice: I18n.t('controllers.sessions.logged_in')
    else
      flash.now.alert = 'Неправильная почта или пароль'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t('controllers.sessions.logged_out')
  end
end
