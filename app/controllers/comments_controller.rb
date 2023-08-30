class CommentsController < ApplicationController
  before_action :get_topic_and_post
  before_action :set_comment, only: [:create, :destroy, :show]

  def show
    @comment_ratings = @comment.comment_ratings.find_by(user_id: current_user.id) || @comment.comment_ratings.new
  end

  def create
    @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_post_path(@topic, @post), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    # @comment.user = current_user

    respond_to do |format|
      format.html { redirect_to topic_post_path(@topic, @post), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_topic_and_post
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
