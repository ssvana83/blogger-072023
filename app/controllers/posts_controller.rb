class PostsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :no_route
before_action :find_post, only: [:show, :update, :destroy]

  def index #same as get "/posts"
    render json: Post.all
  end

  def ordered #this is a custom route
    render json: Post.sort_desc_by_title
  end

  def show #show route same as get "/posts/:id" do
    render json: serialized_post
  end

  def create #post "/posts"
    @post = Post.create!(post_params)
    if @post.id
      render json: serialized_post, status: 201
    else
      render json: {error: post.errors.full_messages.to_sentence}
    end
  end

  def update #patch "posts/:id"
    if @post&.update!(post_params)
      render json: serialized_post
    else
      render json: {error: @post.errors.full_messages.to_sentence}
    end
  end

  def destroy #delete "/posts/:id"
    if @post&.destroy
      render json: {message: "deleted post!"}
    else
      render json: {error: @post.errors.full_messages.to_sentence}
    end
  end

  private
  def find_post
    @post = Post.find(params[:id])
  end

  def serialized_post
    @post.to_json(include: :comments)
  end

  def post_params
    params.require(:post).permit(:title, :content, :media_url, :delete_time)
  end

  def no_route
    render json: {error: "Could not find a post with id #{params[:id]}"}.to_json
  end

end
