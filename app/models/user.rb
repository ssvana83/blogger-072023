class User < ApplicationRecord
  has_secure_password
  
  has_many :written_posts, foreign_key: 'user_id', class_name: 'Post', dependent: :destroy
  has_many :comments
  has_many :posts, through: :comments

  validates :username, uniqueness: true, presence: true, length: {in: 3..33}
  validates :email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password, length: { minimum: 5}
end

