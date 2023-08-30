class CommentRatingsController < ApplicationController
  before_action :get_topic_post_comment
  before_action :set_comment_rating,only: [:update]

  def create
    @comment_rating = @comment.comment_ratings.build(comment_ratings_params)
    @comment_rating.user_id = current_user.id
    @comment_rating.update(comment_ratings_params)
    if @comment_rating.save
      redirect_to topic_post_path(@topic,@post), notice: 'Rating submitted successfully.'
    else
      redirect_to topic_post_path(@topic,@post), alert: 'Failed to submit rating.'
    end
  end

  def update
    @comment_rating = @comment.comment_ratings.find_by(user_id: current_user.id)
    if @comment_rating.update(comment_ratings_params)
      redirect_to topic_post_path(@topic,@post), notice: 'Rating updated successfully.'
    else
      redirect_to topic_post_path(@topic,@post), alert: 'Failed to update rating.'
    end
  end


  private

  def get_topic_post_comment
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
  end

  def set_comment_rating
    @comment_rating = @comment.comment_ratings.find(params[:id])
  end

  def comment_ratings_params
    params.require(:comment_rating).permit(:comment_id,:value)
  end
end
