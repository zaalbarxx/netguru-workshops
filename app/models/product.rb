class Product < ActiveRecord::Base
  validates_presence_of :price, :description, :title
  validates_format_of :price, :with => /\A[\d]+\.?[\d]{0,2}\Z/
  belongs_to :category
  belongs_to :user
  has_many :reviews

  def average_rating
    self.reviews.average('rating')
  end
  def belongs_to_user?(user)
    if self.user
      self.user.id == user.id
    else
      false
    end

  end
end
