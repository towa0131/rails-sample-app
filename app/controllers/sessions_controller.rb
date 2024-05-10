class SessionsController < ApplicationController
  def create
    unless auth_hash[:uid] 
      flash[:danger] = '連携に失敗しました' 
      redirect_to root_url
    end
    user = User.find_by(uid: auth_hash[:uid]) 
    if user
      log_in(user) 
      redirect_to root_url
    else
      if auth_hash[:info][:email].nil?
        # Twitter
        image_url = auth_hash[:info][:image].gsub!("_normal", "")
      else
        # Google
        image_url = auth_hash[:info][:image]
      end

      vid = SecureRandom.uuid_v7.gsub!("-", "")
      while User.exists?(vid: vid) do
        vid = SecureRandom.uuid_v7.gsub!("-", "")
      end
      
      new_user = User.new(
        uid: auth_hash[:uid], 
        nickname: auth_hash[:info][:name], 
        name: auth_hash[:info][:name],
        image: image_url,
        email: auth_hash[:info][:email],
        bio: "",
        vid: vid
      )
      if new_user.save 
        log_in(new_user) 
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

    redirect_to root_url 
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
