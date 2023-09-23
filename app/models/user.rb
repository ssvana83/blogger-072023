class User < ApplicationRecord
  has_secure_password
  # this validates for presence already so dont validate password below 
  # this is a macro from ActiveRecord that includes many instance methods 
  has_many :posts, dependent: :destroy

  validates :username, presence: true, length: {in: 3..33}
  validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  # the above is regex formatted validation, can also use a gem*
  validates :password, presence: true, length: { minimum: 5}
end
