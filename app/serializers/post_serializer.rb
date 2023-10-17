class PostSerializer < ActiveModel::Serializer
  
  attributes :title, :content, :media_url, :id, :user_id
  # should this be user_id since in schema thats what it is or just :id?
  
  has_many :comments  #, serializer: CommentSerializer
# this points to what serializer is used 


end

# attribute :comments do |object|
  #   CommentSerializer.new(object.comments)
  # end

  # above is example of calling serializer with an override. 
  # attribute :post that takes in a block |object|

# :delete_time was taken out from attributes line

