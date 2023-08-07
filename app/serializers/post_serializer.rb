class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :media_url, :delete_time
  has_many :comments, serializer: CommentSerializer
end
