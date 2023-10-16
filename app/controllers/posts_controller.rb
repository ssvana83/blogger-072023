class PostsController < ApplicationController
  # skip_before_action :authorized!, only: [:index]
  before_action :find_post, only: [:show, :update, :destroy]
  before_action :authorized!, only: [:create]

  def index #same as get "/posts"
    render json: Post.all
  end

  def ordered #this is a custom route that calls on route in route.rb
    render json: Post.sort_desc_by_title
  end

  def show #show route same as get "/posts/:id" do
    render json: serialized_post
  end

  def create #post "/posts"
    
    @post = @current_user.posts.create!(post_params)
      render json: @post
      # serialized_post, status: 201
  end

  def update #patch "posts/:id"
    if current_user.posts.include?(@post)
      @post&.update!(post_params)
      render json: serialized_post
    else
      no_route
    end
  end

  def destroy #delete "/posts/:id"
    if current_user.posts.include?(@post)
        if @post&.destroy
          render json: {message: "deleted post!"}
          else
          render json: {error: @post.errors.full_messages.to_sentence}
        end
      else
      no_route
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
    params.permit(:title, :content, :media_url)
  end

end
