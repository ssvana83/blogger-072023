class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :update, :destroy]
   
  def index #get "/comments" doesnt make sense so get "posts/:post_id/comments"
    if params[:post_id] #is there a routes parameter? (Do come froIm a nested route?)
      post = Post.find(params[:post_id])
      render json: post.comments
    else #get "/comments" to pull from route that wants all comments to render
      render json: Comment.all
      # line above changed from line below once serializer was implemented 
      # render json: Comment.all.to_json(include: :post)
    end
  end

  def show #show route same as get "/comments/:id" do
    render json: serialized_comment
  end

  def create #post "/comments"
    if params[:post_id] #is there a routes parameter?
      post = Post.find(params[:post_id])
      # if ([params[:content], params[:rating]].any?{|val| val.strip == ""})
        # this is a validation
      # end
      @comment = post.comments.create!(comment_params)
      if @comment.id
        render json: serialized_comment, status: 201
      else
        render json: {error: @comment.errors.full_messages.to_sentence}, status: 404
      end
    end
  end
  # the create! enables the removal of code that follows it (except for line 23)  because it indicates
  # the raising of an exeption. Dont need the if/then, because it states that if it doesnt work
  #  execption rescue, frontend here are the errors and then give back sserialized 

  def update #patch "comments/:id"
    if @comment&.update(comment_params)
      render json: serialized_comment
    else
      render json: {error: @comment.errors.full_messages.to_sentence}
    end
  end

  def destroy #delete "/comments/:id"
    if @comment&.destroy
      render json: {message: "deleted post!"}
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
    params.require(:comment).permit(:rating, :content, :post_id)
  end

  def no_route
    render json: {error: "Could not find a post with id #{params[:id]}"}.to_json
  end
end
