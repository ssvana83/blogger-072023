class PostSerializer < ActiveModel::Serializer
  
  attributes :title, :content, :media_url, :id
  # :delete_time was taken out from above line
  has_many :comments, serializer: CommentSerializer
# this points to what serializer is used 

  # attribute :comments do |object|
  #   CommentSerializer.new(object.comments)
  # end

  # above is example of calling serializer with an override. 
  # attribute :post that takes in a block |object|
end

