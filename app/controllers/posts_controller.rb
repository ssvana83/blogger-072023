class PostsController < ApplicationController
  skip_before_action :authorized!, only: [:index]
  before_action :find_post, only: [:show, :update, :destroy]

  def index #same as get "/posts"
    render json: Post.all
  end

  def show #show route same as get "/posts/:id" do
    render json: @post
  end

  def create #post "/posts"
    @post = @current_user.posts.create!(post_params)
    render json: @post
  end

  def update #patch "posts/:id"
        if @current_user.posts.include?(@post)
        if @post.update(post_params)
        render json: @post
    else
        render json: { error: @post.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
    else
        no_route
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.user == @current_user
      if @post.destroy
        render json: { message: "Post deleted" }
      else
        render json: { error: "unable to delete this post" }
      end
   else
      render json: { error: "unauthorized to delete this post"}
    end
  end

  # def destroy
  #   @post = Post.find(params[:id])
  #   @post.destroy
  # end


  private
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:title, :content, :media_url)
  end

end
