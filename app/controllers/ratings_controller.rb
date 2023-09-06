class RatingsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @rating = @post.ratings.build(rating_params)
    if @rating.save
      flash[:success] = 'Rating added successfully.'
      redirect_to topic_post_path(@topic, @post)
    else
      render :new, status: :unprocessable_entity
      flash[:danger] = 'Rating creation failed.'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
