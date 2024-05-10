class StaticPagesController < ApplicationController
  def home
    if logged_in
      @posts = Post.all.order(created_at: "DESC")
      @new_post = current_user.posts.new
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
