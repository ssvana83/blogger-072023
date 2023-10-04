class UserSerializer #< ActiveModel::Serializer
  include JSONAPI::Serializer
  
  attributes :id, :username, :email, :password_digest
  has_many :posts
end
