class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :redirect_if_not_owner_of_product, only: [:edit, :update, :destroy]
  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews) {product.reviews.eager_load(:user).order(updated_at: :desc)}

  def index
  end

  def show
  end

  def new
  end

  def edit

  end

  def create
    self.product = Product.new(product_params)
    self.product.user_id = current_user.id
    if product.save
      category.products << product
      redirect_to category_product_url(category, product), notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    self.product.user_id = current_user.id
    if self.product.update(product_params)
      redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /products/1
  def destroy
    product.destroy
    redirect_to category_url(product.category), notice: 'Product was successfully destroyed.'
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end

  def redirect_if_not_owner_of_product
    if !product.belongs_to_user?(current_user)
      redirect_to(category_product_url(category, product),
                  :flash => {:error => 'You are not allowed to edit this product.'})
    end
  end
end
