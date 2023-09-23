class Comment < ApplicationRecord
  # @@bad_words = %w(dangit fudge darnit) remove this when changing to custom validation
  belongs_to :post #will auto validate post_id existance
  validates :rating, presence: true, numericality: {less_than_or_equal_to: 10, greater_than_or_equal_to: 1}
  validates :content, presence: true, length: {in: 2..300}
  # take this part out to make it a custom validation instead:
  # inclusion: {in: %w(dangit fudge darnit), message: "Thats not nice, you cant say: #{@@bad_words.join(", ")}"}
  validate :clean_words_check
  

  def clean_words_check
    bad_words = %w(dangit fudge shoot)
    # if clean_words.any?{|cw| self.content.split("")}.include(cw)
    # take above out and insert below instead (cleaner)
      if self.content.match? /(dangit|fudge|shoot)/i
        self.errors.add(:content, :inappropriate, message: "Thats not nice, you cant say: #{bad_words.join(",")}")
      end
    end
end
