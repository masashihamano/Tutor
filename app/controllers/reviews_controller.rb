class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.sharing
  end

  def destroy
    @review = Review.find(params[:id])
    sharing = @review.sharing
    @review.destroy
    redirect_to sharing
  end

  private
  def review_params
    params.require(:review).permit(:description, :rate, :sharing_id)
  end

end
