class PostSerializer < ActiveModel::Serializer
  attributes :title, :content, :media_url, :id, :user_id
  has_many :comments  
end

