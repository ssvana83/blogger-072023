class CommentSerializer 
  include JSONAPI::Serializer
  attributes :content, :rating, :created_at, 
  belongs_to :post, serializer: PostSerializer
  
  attribute :rating do |object|
    "Rating is #{object.rating}/10"
  end
  
  # attribute :post do |object|
  #   PostSerializer.new(object.post)
  # end

end
