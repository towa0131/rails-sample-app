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

  def show
    @post = Post.find_by(id: params[:id])
    if @post
      @replies = @post.reply_posts.order(created_at: "DESC")
      main_post = @post.main_post 
      @main_posts = [] 
      while main_post do 
          @main_posts.push(main_post) 
          main_post = main_post.main_post 
      end 
    else
      redirect_to root_url
    end
  end

  def reply
    if logged_in
      @post = Post.find_by(id: params[:main_post_id])
      reply_post = current_user.posts.create(content: post_params[:content])
      if (reply_post.valid? && @post)
        @post.passive_reply_relationships.create(reply_post_id: reply_post.id)
      end
      redirect_to request.referer
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :id)
  end
end
