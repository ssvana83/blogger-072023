class PostSerializer 
  include JSONAPI::Serializer
  attributes :title, :content, :media_url, :delete_time, :id
  # has_many :comments, serializer: CommentSerializer
# this points to what serializer is used 

  # attribute :comments do |object|
  #   CommentSerializer.new(object.comments)
  # end

  # above is example of calling serializer with an override. 
  # attribute :post that takes in a block |object|
end


# "includes" JSONAPI::Serializer instead of inheriting from ActiveModel::Serializer
# The difference is in syntax used 

# line 4: has_many line can instead be written as :comments on attributes line