class CommentSerializer < ActiveModel::Serializer
  attributes :content, :rating, :created_at, :user_id
  belongs_to :user
  belongs_to :post
end


# added user_id to line 2 attributes