# spec/controllers/posts_controller_spec.rb

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:topic) { Topic.create(title: "Test Topic", genre: "Test Genre") }

  describe "GET #index" do
    it "renders the index template" do
      get :index, params: { topic_id: topic.id }
      expect(response).to render_template(:index)
    end

    it "assigns @posts with all posts belonging to the topic" do
      post1 = Post.create(description: "Post 1", topic: topic)
      post2 = Post.create(description: "Post 2", topic: topic)

      get :index, params: { topic_id: topic.id }
      expect(assigns(:posts)).to eq([post1, post2])
    end
  end

  describe "GET #show" do
    let!(:post) { Post.create(description: "Test Post", topic: topic) }

    it "renders the show template" do
      get :show, params: { topic_id: topic.id, id: post.id }
      expect(response).to render_template(:show)
    end

    it "assigns @post with the requested post" do
      get :show, params: { topic_id: topic.id, id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new, params: { topic_id: topic.id }
      expect(response).to render_template(:new)
    end

    it "assigns a new @post with the specified topic" do
      get :new, params: { topic_id: topic.id }
      expect(assigns(:post)).to be_a_new(Post).with(topic_id: topic.id)
    end
  end

  describe "GET #edit" do
    let!(:post) { Post.create(description: "Test Post", topic: topic) }

    it "renders the edit template" do
      get :edit, params: { topic_id: topic.id, id: post.id }
      expect(response).to render_template(:edit)
    end

    it "assigns @post with the requested post" do
      get :edit, params: { topic_id: topic.id, id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "POST #create" do
    let(:post_attributes) { { description: "New Post", topic_id: topic.id } }

    context "with valid attributes" do
      it "creates a new post" do
        expect {
          post :create, params: { topic_id: topic.id, post: post_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the topic_posts_path" do
        post :create, params: { topic_id: topic.id, post: post_attributes }
        expect(response).to redirect_to(topic_posts_path(topic))
      end
    end

    context "with invalid attributes" do
      it "does not create a new post" do
        expect {
          post :create, params: { topic_id: topic.id, post: { description: nil, topic_id: topic.id } }
        }.not_to change(Post, :count)
      end

      it "re-renders the new template" do
        post :create, params: { topic_id: topic.id, post: { description: nil, topic_id: topic.id } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let!(:post) { Post.create(description: "Test Post", topic: topic) }

    context "with valid attributes" do
      it "updates the post" do
        patch :update, params: { topic_id: topic.id, id: post.id, post: { description: "Updated description" } }
        post.reload
        expect(post.description).to eq("Updated description")
      end

      it "redirects to the topic_post_path" do
        patch :update, params: { topic_id: topic.id, id: post.id, post: { description: "Updated description" } }
        expect(response).to redirect_to(topic_post_path(topic, post))
      end
    end

    context "with invalid attributes" do
      it "does not update the post" do
        original_description = post.description
        patch :update, params: { topic_id: topic.id, id: post.id, post: { description: nil } }
        post.reload
        expect(post.description).to eq(original_description)
      end

      it "re-renders the edit template" do
        patch :update, params: { topic_id: topic.id, id: post.id, post: { description: nil } }
        expect(response).to render_template(:edit)
      end
    end
    context "with valid attributes" do
      it "updates the post and redirects to the topic_post_path with status 302" do
        patch :update, params: { topic_id: topic.id, id: post.id, post: { description: "Updated description" } }
        post.reload
        expect(post.description).to eq("Updated description")

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(topic_post_path(topic, post))
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post) { Post.create(description: "Test Post", topic: topic) }

    it "destroys the post" do
      expect {
        delete :destroy, params: { topic_id: topic.id, id: post.id }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the topic_posts_path" do
      delete :destroy, params: { topic_id: topic.id, id: post.id }
      expect(response).to redirect_to(topic_posts_path(topic))
    end
  end

  describe "POST #create" do
    let(:post_attributes) { { description: "New Post", topic_id: topic.id } }

    context "with valid attributes" do
      it "creates a new post and redirects to the topic_posts_path with status 302" do
        expect {
          post :create, params: { topic_id: topic.id, post: post_attributes }
        }.to change(Post, :count).by(1)

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(topic_posts_path(topic))
      end
    end

    context "with invalid attributes" do
      it "does not create a new post and re-renders the new template with errors" do
        expect {
          post :create, params: { topic_id: topic.id, post: { description: nil, topic_id: topic.id } }
        }.not_to change(Post, :count)

        expect(response).not_to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end
  end

end