class UsersController < ApplicationController
  def show
    @user = User.find_by(vid: params[:vid])
    if @user
      @posts = @user.posts.order(created_at: "DESC")
    else
      redirect_to root_url
    end
  end

  def index
    @users = User.all
  end

  def update
    user = User.find_by(uid: session[:uid])
    vid = post_params[:vid]
    nickname = post_params[:nickname]

    if User.exists?(vid: vid) && user.vid != vid
      flash[:danger] = "The ID already exists."
    else
      user.vid = vid
      user.nickname = nickname
      user.save
    end

    redirect_to "/#{user.vid}"
  end

  private
  
  def post_params
    params.require(:user).permit(:nickname, :vid)
  end
end
