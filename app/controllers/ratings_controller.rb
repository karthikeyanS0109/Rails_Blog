class RatingsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @rating = @post.ratings.build(rating_params)
    if @rating.save
      redirect_to topic_post_path(@topic, @post), notice: 'Rating added successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
