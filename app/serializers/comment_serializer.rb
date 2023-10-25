class CommentSerializer < ActiveModel::Serializer
  attributes :content, :rating, :created_at 
  # belongs_to :post
end
