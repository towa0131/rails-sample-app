class SessionsController < ApplicationController
  def create
    unless auth_hash[:uid] 
      flash[:danger] = '連携に失敗しました' 
      redirect_to root_url
    end
    user = User.find_by(uid: auth_hash[:uid]) 
    if user
      log_in(user) 
      flash[:success] = 'ログインしました' 
      redirect_to root_url
    else
      if auth_hash[:info][:last_name].nil?
        user_name = auth_hash[:info][:name]
      else
        user_name = "#{auth_hash[:info][:last_name]} #{auth_hash[:info][:first_name]}"
      end
      new_user = User.new(
        uid: auth_hash[:uid], 
        nickname: auth_hash[:info][:name], 
        name: user_name,
        image: auth_hash[:info][:image],
        email: auth_hash[:info][:email]
      )
      if new_user.save 
        log_in(new_user) 
        flash[:success] = 'ユーザー登録成功' 
      else 
        flash[:danger] = '予期せぬエラーが発生しました' 
      end 
      redirect_to root_url 
    end
  end

  def destroy
    if logged_in
      log_out
    end

    flash[:success] = 'ログアウトしました' 
    redirect_to root_url 
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
