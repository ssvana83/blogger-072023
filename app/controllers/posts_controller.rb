class PostsController < ApplicationController
  skip_before_action :authorized!, only: [:index]
  before_action :find_post, only: [:show, :update, :destroy]
  # before_action :authorized!, only: [:create]

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

  # def destroy #delete "/posts/:id"
  #   if @current_user.posts.include?(@post)
  #       if @post&.destroy
  #         head :no_content
  #         else
  #         render json: {error: @post.errors.full_messages.to_sentence}, status: :unprocessable_entity
  #       end
  #     else
  #     no_route
  #   end
  # end

  def destroy
      @current_user.posts.include?(@post)
      if @current_user
        @current_user.destroy
        head :no_content
      else
        "Couldnt find post"
      end
  end

  private
  def find_post
    @post = Post.find(params[:id])
  end

  # def serialized_post
  #   @post.to_json(include: :comments)
  # end

  def post_params
    params.permit(:title, :content, :media_url)
  end

end
