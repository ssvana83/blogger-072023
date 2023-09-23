class Post < ApplicationRecord
  has_many :comments #17 methods comments(getter), comments=(setter)
  belongs_to :user
  validates :title, :content, :delete_time, presence: true
  validates :content, length: {in: (10..500)}
  validate :delete_time_in_the_future?

  before_save :format_title #model filter example call
  # scope method: its a macro that helps create class methods (not used with instance methods) used for queries.
  # scope replaces def and self. from methods below
  # scope :most_comments, -> {self.joins(:comments).group(:post_id).order("COUNT(posts.id) DESC").limit(1)}
  scope :sort_desc_by_title, -> {self.order(title: :desc)}
  

  # model filter example method
  def format_title
    if self.title[0] != self.title[0].upcase
      #split at every word self.title.split("")
      self.title = self.title.capitalize
    end
  end

  def delete_time_in_the_future?
    if !!self.delete_time && self.delete_time <= DateTime.current
      self.errors.add(:delete_time, :time_confusion, message: "The delete time cant be in the past")
    end
  end

  # can use a schedule for this if I want later...not being used now
  def automatic_destroy
    if self.delete_time <= DateTime.current
      self.destroy
    end
  end

  # class method called on self hey class of your children give me what you have, not asking a sibling
  def self.most_comments
    # self.all.max_by{|p| p.comments.length}
    # preload is more efficient so it doesnt quesry x3 for each post/comment. This is reducing m+1 queries
    self.preload(:comments).all.max_by{|p| p.comments.length}
    # self(class)joins comments table and then once we have all the data (since interjoin between post/comments)
    # lets regroup by post id. then order based on the count of the comments on each group in descending order
    # .limit gives object, without it it give AR relation
    self.joins(:comments).group(:post_id).order("COUNT(posts.id) DESC").limit(1)
  end

end
