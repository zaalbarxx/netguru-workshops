class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :firstname
  validates_presence_of :lastname

  has_many :reviews
  has_many :products

  def admin?
    self[:admin]
  end

  def name
    "#{self[:firstname]} #{self[:lastname]}"
  end
end
