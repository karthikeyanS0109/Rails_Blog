require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all tags to @tags' do
      tag1 = Tag.create(name: 'Tag1')
      tag2 = Tag.create(name: 'Tag2')
      get :index
      expect(assigns(:tags)).to match_array([tag1, tag2])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      tag = Tag.create(name: 'Tag')
      get :show, params: { id: tag.id }
      expect(response).to be_successful
    end

    it 'assigns the requested tag to @tag' do
      tag = Tag.create(name: 'Tag')
      get :show, params: { id: tag.id }
      expect(assigns(:tag)).to eq(tag)
    end

    it 'assigns posts associated with the tag to @posts' do
      tag = Tag.create(name: 'Tag')
      topic = Topic.create(title: 'Topic', genre: 'Genre') # Create a topic
      post1 = tag.posts.create(description: 'Description 1', topic: topic)
      post2 = tag.posts.create(description: 'Description 2', topic: topic)
      get :show, params: { id: tag.id }
      expect(assigns(:posts)).to match_array([post1, post2])
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new tag to @tag' do
      get :new
      expect(assigns(:tag)).to be_a_new(Tag)
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      tag = Tag.create(name: 'Tag')
      get :edit, params: { id: tag.id }
      expect(response).to be_successful
    end

    it 'assigns the requested tag to @tag' do
      tag = Tag.create(name: 'Tag')
      get :edit, params: { id: tag.id }
      expect(assigns(:tag)).to eq(tag)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new tag' do
        expect {
          post :create, params: { tag: { name: 'New Tag' } }
        }.to change(Tag, :count).by(1)
      end

      it 'redirects to the created tag' do
        post :create, params: { tag: { name: 'New Tag' } }
        expect(response).to redirect_to(tag_path(Tag.last))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new tag' do
        expect {
          post :create, params: { tag: { name: '' } }
        }.to_not change(Tag, :count)
      end

      it 'renders the new template' do
        post :create, params: { tag: { name: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:tag) { Tag.create(name: 'Original Tag') }

    context 'with valid attributes' do
      it 'updates the tag' do
        patch :update, params: { id: tag.id, tag: { name: 'Updated Tag' } }
        tag.reload
        expect(tag.name).to eq('Updated Tag')
      end

      it 'redirects to the updated tag' do
        patch :update, params: { id: tag.id, tag: { name: 'Updated Tag' } }
        expect(response).to redirect_to(tag_path(tag))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the tag' do
        patch :update, params: { id: tag.id, tag: { name: '' } }
        tag.reload
        expect(tag.name).to eq('Original Tag')
      end

      it 'renders the edit template' do
        patch :update, params: { id: tag.id, tag: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the tag' do
      tag = Tag.create(name: 'Tag')
      expect {
        delete :destroy, params: { id: tag.id }
      }.to change(Tag, :count).by(-1)
    end

    it 'redirects to the index page' do
      tag = Tag.create(name: 'Tag')
      delete :destroy, params: { id: tag.id }
      expect(response).to redirect_to(tags_url)
    end
  end
end
