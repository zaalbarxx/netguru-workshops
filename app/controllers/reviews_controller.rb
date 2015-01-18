class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :update, :create]
  before_action :redirect_if_not_admin, only: [:destroy]

  expose(:review)
  expose(:product)
  expose(:category){ product.category}
  expose_decorated(:reviews, ancestor: :product)

  def edit
  end

  def create
    self.review = Review.new(review_params)
    self.review.user_id = current_user.id
    respond_to do |format|
      if review.save
        product.reviews << review
        format.html {render :partial => "reviews/review"}
        format.json {render json: {
          review: render_to_string(partial: 'reviews/review.html.haml', locals: { review: review.decorate })
        }, status: :created}
      else
        format.html {render :partial => "reviews/form", status: :unprocessable_entity}
        format.json {render json: {
          errors: render_to_string(partial: 'reviews/form_errors.html.haml', locals: { review: review.decorate })
        }, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    review.destroy
    respond_to do |format|
      format.html {redirect_to(category_product_url(category, product), {notice: 'Review was deleted.'})}
      format.json {render json: {}, status: :deleted}
    end
  end

  private
    def review_params
      params.require(:review).permit(:content, :rating)
    end
end
