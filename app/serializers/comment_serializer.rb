class CommentSerializer < ActiveModel::Serializer
  # include JSONAPI::Serializer
  attributes :content, :rating, :created_at 
  # belongs_to :post
  
  # attribute :rating do |object|
  #   "Rating is #{object.rating}/10"
  # end
  
  # below is another syntax for noting serializer instead of belongs_to line
  # attribute :post do |object|
  #   PostSerializer.new(object.post)
  # end

end


# belongs_to can also be written as :post on attribute line
# use object property to get to class since self in would be the class serializer
# attribute :rating can override attributes of rating

# syntax changes using < ActiveModel::Serializer
# 
