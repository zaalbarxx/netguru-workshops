class UsersController < ApplicationController
  before_action :authenticate_user!
  expose(:users)

  def list
  end

  def profile
    @user = current_user.id === params[:id] ? current_user : User.find(params[:id])
    @products = @user.products.preload(:category).all
    @reviews = @user.reviews.preload(:product).order('created_at').limit(5)
    @user_reviews_count = @user.reviews.count
  end
end
