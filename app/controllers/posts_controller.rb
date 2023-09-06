class PostsController < ApplicationController
  before_action :get_topic
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts =  (if @topic.present?
                      (@topic.posts.all.includes([:comments, :ratings]))
                      if params[:from_date].present? && params[:to_date].present?
                        @from_date = Date.parse(params[:from_date])
                        @to_date = Date.parse(params[:to_date])
                      else
                        # If no parameters provided, set default date range
                        @from_date = 1.day.ago.to_date
                        @to_date = Date.current
                      end

                      @filtered_posts = @topic.posts.filtered_by_date_range(@from_date, @to_date)
              else
                Post.all.includes(:topic)
               end)
  end
  # GET /posts/1 or /posts/1.json
  def show
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    @tag = @post.tags
    @rating = Rating.new
    @rating_counts = @post.ratings.group(:value).count
  end

  # GET /posts/new
  def new
    @post = @topic.posts.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /posts/1/edit
  def edit
    authorize! :update, @post
  end

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.build(post_params.except(:tags))
    create_or_delete_posts_tag(@post, params[:post][:tags])
    @post.user = current_user

    respond_to do |format|
      if @post.save
        @rating_counts = @post.ratings.group(:value).count
        format.html { redirect_to topic_post_path(@topic, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js { render "posts/errors" }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    create_or_delete_posts_tag(@post, params[:post][:tags])
    @post.user = current_user

    respond_to do |format|
      if @post.update(post_params.except(:tags))
        format.html { redirect_to topic_post_path(@topic), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize! :destroy, @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to topic_posts_path(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def read_unread
    @post = Post.find(params[:id])
    @post.users << current_user
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def create_or_delete_posts_tag(post, tags)
        post.taggables.destroy_all
        tags = tags.to_s.strip.split(',')
        tags.each do |tag|
          post.tags << Tag.find_or_create_by(name: tag.strip) unless tag.blank?
        end
    end

    def get_topic
      @topic = Topic.find(params[:topic_id]) if params[:topic_id].present?
    end
    def set_post
      @post = @topic.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :topic_id, :tags, :image)
    end
end
