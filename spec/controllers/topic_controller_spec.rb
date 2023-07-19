# spec/controllers/topics_controller_spec.rb

require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe 'index template' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      topic = Topic.create(
        title: 'One Piece',
        genre: 'Fantasy'
      )

      get :show, params: { id: topic.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      topic = Topic.create(
        title: 'One Piece',
        genre: 'Fantasy'
      )

      get :edit, params: { id: topic.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    it 'redirects to the show page after successful creation' do
      post :create, params: {
        topic: {
          title: 'One Piece',
          genre: 'Fantasy'
        }
      }
      expect(response).to redirect_to(assigns(:topic))
    end
  end
  #======================================http status code====================
  describe 'GET #index' do
    it 'returns a successful HTTP status code (200)' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'returns a successful HTTP status code (200)' do
      topic = Topic.create(
        title: 'One Piece',
        genre: 'Fantasy'
      )

      get :show, params: { id: topic.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'returns a successful HTTP status code (200)' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful HTTP status code (200)' do
      topic = Topic.create(
        title: 'One Piece',
        genre: 'Fantasy'
      )

      get :edit, params: { id: topic.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          topic: {
            title: 'One Piece',
            genre: 'Fantasy'
          }
        }
      end

      it 'redirects to the show page after successful creation' do
        post :create, params: valid_params
        expect(response).to have_http_status(302) # 302 for redirect
      end

      it 'creates a new topic in the database' do
        expect { post :create, params: valid_params }.to change(Topic, :count).by(1)
      end
    end

    # context 'with invalid parameters' do
    # Add tests for invalid parameters if needed.
    # end
  end
  # ... additional tests for other controller actions (update, destroy) ...

  # =============================flash notice=======================
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          topic: {
            title: 'One Piece',
            genre: 'Fantasy'
          }
        }
      end

      it 'creates a new topic in the database' do
        expect { post :create, params: valid_params }.to change(Topic, :count).by(1)
      end

      it 'redirects to the show page after successful creation' do
        post :create, params: valid_params
        expect(response).to redirect_to(assigns(:topic))
        expect(flash[:notice]).to eq('Topic was successfully created.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          topic: {
            title: 'One Piece'
          }
        }
      end

      it 'does not create a new topic in the database' do
        expect { post :create, params: invalid_params }.not_to change(Topic, :count)
      end

      it 're-renders the new template with a flash alert' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Topic could not be created. Please fix the errors.')
      end
    end
  end



end