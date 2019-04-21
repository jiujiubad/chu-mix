class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_post, only: [:like, :unlike, :toggle_flag]

  def index
    @posts = Post.order("id DESC").limit(10)
    if params[:max_id]
      @posts = @posts.where("id < ?", params[:max_id])
    end
    respond_to do |format|
      format.html # 如果客户端要求 HTML，则回传 index.html.erb
      format.js # 如果客户端要求 JavaScript，回传 index.js.erb
    end
  end

  def create
    @post      = Post.new(post_params)
    @post.user = current_user
    @post.save
  end

  def destroy
    @post = current_user.posts.find(params[:id]) # 只能删除自己的文章
    @post.destroy
    render json: { id: @post.id }
  end

  def like
    unless @post.find_like(current_user) # 如果已经点赞过了，就略过不再新增
      Like.create(user: current_user, post: @post)
    end
  end

  def unlike
    like = @post.find_like(current_user)
    like.destroy
    render :like
  end

  def toggle_flag
    if @post.flag_at
      @post.flag_at = nil
    else
      @post.flag_at = Time.now
    end
    @post.save!
    render json: { message: "ok", flag_at: @post.flag_at, id: @post.id }
  end

  protected

  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
