class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :comment]
  before_action :comment_params, only: [:comment]

  # GET /posts
  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 2)
  end

  def comment
    @comment = Comment.new(comment_params)
    @post.comments << @comment
    current_user.comments << @comment
    redirect_to :back
  end

  # GET /posts/1
  def show
    @comment = Comment.new
    @comments = @post.comments.paginate(page: params[:page], per_page: 2)
  end

  # GET /posts/new
  def new
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
