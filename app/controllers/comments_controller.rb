class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :update, :destroy]
   
  def index                              # get "/comments" but this makes more sense: #get "posts/:post_id/comments"
    if params[:post_id]                  # is there a post parameter? if so, we are in a nested route
        post = Post.find(params[:post_id])
        render json: post.comments
    else                                 # get "/comments"
      render json: Comment.all
    end
  end

  def show                              # show route same as get "/comments/:id" do
    render json: @comment
  end


  def create #post "/comments"
      if params[:post_id] #is there a routes parameter?
        post = Post.find(params[:post_id])
        @comment = post.comments.create!(comment_params)    
        # render json: serialized_comment, status: 201
        render json: @comment, status: 201
      end
  end

   
  def update #patch "comments/:id"
    if @comment&.update(comment_params)
      render json: serialized_comment
    else
      render json: {error: @comment.errors.full_messages.to_sentence}
    end
  end

  def destroy                                                     #delete "/comments/:id"
    if @comment&.destroy
      render json: {message: "Comment Deleted!"}
    else
      render json: {error: @comment.errors.full_messages.to_sentence}
    end
  end

  private
  def find_comment
    @comment = Comment.find(params[:id])
  end

  def serialized_comment
    @comment.to_json(include: :post)
  end

  def comment_params
    params.permit(:rating, :content, :post_id, :user_id)
  end

end


# @comment = post.comments.create!(comment_params)
# Explanation; On the post we found, get the list of comments, create a new comment. This will create but also
# establish the relationship
# "post"(outer/independant resource) "."(apply) "comments"(dependant/inner resource-pluralized)
# .create!(shows associations)
# create! to raise execption so that you dont need additional if/else