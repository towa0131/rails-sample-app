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
    bio = post_params[:bio]

    if User.exists?(vid: vid) && user.vid != vid
      flash[:danger] = "The ID already exists."
    else
      user.vid = vid
      user.nickname = nickname
      user.bio = bio
      user.save
    end

    redirect_to "/#{user.vid}"
  end

  def show_followers
    @user = User.find_by(vid: params[:vid])
    if @user
      @followers = @user.followers.order(created_at: "DESC")
    else
      redirect_to root_url
    end
  end

  def show_followings
    @user = User.find_by(vid: params[:vid])
    if @user
      @followings = @user.followings.order(created_at: "DESC")
    else
      redirect_to root_url
    end
  end

  private
  
  def post_params
    params.require(:user).permit(:nickname, :vid, :bio)
  end
end
