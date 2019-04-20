class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post, only: [:like, :unlike]

  def index
    @posts = Post.order("id DESC").all # 新文章放前面
  end

  def create
    @post      = Post.new(post_params)
    @post.user = current_user
    @post.save
    # redirect_to posts_path
  end

  def destroy
    @post = current_user.posts.find(params[:id]) # 只能删除自己的文章
    @post.destroy
    # redirect_to posts_path
    # render :js => "alert('ok');"
  end

  def like
    unless @post.find_like(current_user) # 如果已经点赞过了，就略过不再新增
      Like.create(user: current_user, post: @post)
    end
  end

  def unlike
    like  = @post.find_like(current_user)
    like.destroy
    render :like
  end

  protected

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
