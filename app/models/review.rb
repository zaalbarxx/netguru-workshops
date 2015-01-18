class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates_presence_of :content, :rating, :user_id
  validates_numericality_of :rating, {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    message: 'Rating must be between 1 and 5'
  }
end
