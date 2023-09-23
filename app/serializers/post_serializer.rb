class PostSerializer 
  include JSONAPI::Serializer
  attributes :title, :content, :media_url, :delete_time, :id, :comments
  # has_many :comments, serializer: CommentSerializer

  attribute :comments do |object|
    CommentSerializer.new(object.comments)
  end

end


