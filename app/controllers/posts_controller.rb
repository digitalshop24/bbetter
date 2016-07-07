class PostsController < ApplicationController
  layout 'home'
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :comment]
  before_action :comment_params, only: [:comment]

  # GET /posts
  def index
    @user = User.new
    @posts = Post.all.paginate(page: params[:page], per_page: 5)
  end

  def comment
    @comment = Comment.new(comment_params)
    @post.comments << @comment
    current_user.comments << @comment
    redirect_to :back
  end

  # GET /posts/1
  def show
    @user = User.new
    @comment = Comment.new
    @comments = @post.comments.paginate(page: params[:page], per_page: 10)
  end

  # GET /posts/new
  def new
    @user = User.new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    current_user.posts << @post
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:title, :content)
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:name, :title, :content)
    end
end
