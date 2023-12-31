class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]

  # GET /tags or /tags.json
  def index
    # @topic = Topic.find(params[:topic_id])
    @tags = Tag.all
    # redirect_to topic_post_url
  end

  def posts
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
  end

  # GET /tags/1 or /tags/1.json
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        flash[:success] = 'Tag was successfully created.'
        format.html { redirect_to tag_url(@tag) }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
        flash[:danger] = 'Tag creation failed.'
      end
    end
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        flash[:update] = 'Tag was successfully updated.'
        format.html { redirect_to tag_url(@tag) }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
        flash[:danger]= 'Tag update failed.'
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @tag.destroy

    respond_to do |format|
      flash[:danger] = 'Tag was successfully destroyed.'
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
