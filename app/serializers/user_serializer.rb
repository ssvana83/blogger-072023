class UserSerializer #< ActiveModel::Serializer
  include JSONAPI::Serializer

  attributes :id, :username, :email
  has_many :posts
end
