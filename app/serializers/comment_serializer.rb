class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :rating, :post_id
  belongs_to :post, serializer: PostSerializer
  # can remove line above and just add the :post method to attributes above. Doing a 
  # belongs_to asscoiations makes it easier to add excepts though

  # can override rating example below;
  def rating
    "Rating is #{object.rating}/10"
  end
  # self is the instance that we are in ehich is comment serializer class not coment class

end
