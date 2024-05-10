class PostsController < ApplicationController
  def create
    if current_user
      current_user.posts.create(content: post_params["content"])
      redirect_to request.referer
    end
  end

  def destroy
    if (post = Post.find(params["id"].to_i)) && (current_user.id == post.user_id)
      post.destroy
    else
      flash[:danger] = "Failed to delete post."
    end
    redirect_to request.referer
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :id)
  end
end
