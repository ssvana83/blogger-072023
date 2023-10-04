class User < ApplicationRecord
  has_secure_password
  # this validates for presence already so dont validate presense in password below 
  # this is a macro from ActiveRecord that includes many instance methods 
  has_many :posts, dependent: :destroy

  validates :username, uniqueness: true, presence: true, length: {in: 3..33}
  validates :email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  # the above is regex formatted validation, can also use a gem* EmailValidator
  validates :password, length: { minimum: 5}
end
