class StaticPagesController < ApplicationController
  def home
    if logged_in
      @new_post = current_user.posts.new
      following_ids = "SELECT followed_id FROM follow_relationships WHERE follower_id = :user_id"
      @posts = Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: current_user.id).order(created_at: "DESC")
    end
  end

  def login
    if logged_in
      redirect_to root_url
    end
  end

  def profile
    if !logged_in
      redirect_to root_url
    end
  end
end
