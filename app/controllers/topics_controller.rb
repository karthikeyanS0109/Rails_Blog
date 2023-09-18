class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show edit update destroy ]
  before_action :redirect_to_topic_path, only: [:edit]

  # GET /topics or /topics.json
  def index
    @pagy,@topics = pagy(Topic.all,items:5)

  end

  # GET /topics/1 or /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics or /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        # CreateTopicJob.perform_later(current_user)
        flash[:success] = 'Topic was successfully created.'
        format.html { redirect_to topics_path }
        format.json { render :index, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
        flash[:danger] = 'Topic creation failed.'
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        flash[:update] = 'Topic was successfully updated.'
        format.html { redirect_to topics_path }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
        flash[:danger] = 'Topic update failed.'
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      flash[:danger] = 'Topic was successfully destroyed.'
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  def search
    search = "%#{params[:search]}%"
    @topics = Topic.where("title LIKE ?", search)
  end

  def sample
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.require(:topic).permit(:title, :genre)
    end
  def redirect_to_topic_path
    render plain: "Hello World"
  end
end
