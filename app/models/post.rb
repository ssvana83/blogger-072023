class Post < ApplicationRecord
  has_many :comments 
  has_many :users, through: :comments
  belongs_to :user
  
  validates :title, :content, presence: true # validates used for custom validations
  validates :content, length: {in: (10..500)}
  before_save :format_title # this is a model filter call 
  scope :sort_desc_by_title, -> {self.order(title: :desc)} # this is a macro that helps create class methods used for queries
  # without using def and self. like in some methods below. Your controller leverages this.
  
  def format_title  # this is a model filter method
    if self.title[0] != self.title[0].upcase
      self.title = self.title.capitalize
    end
  end

  def self.most_comments
    self.preload(:comments).all.max_by{|p| p.comments.length}
    self.joins(:comments).group(:post_id).order("COUNT(posts.id) DESC").limit(1)
  end

end

# Explanation for self.most_comments class method above;
# It's a class method called on self, "hey class of your children give me what you have" (not asking a sibling)
# self.all.max_by{|p| p.comments.length}
# preload is more efficient so it doesnt query x3 for each post/comment. This is reducing m+1 queries
# self(class)joins comments table and then once we have all the data (since interjoin between post/comments)
# lets regroup by post id. then order based on the count of the comments on each group in descending order
# .limit gives object, without it it gives AR relation


