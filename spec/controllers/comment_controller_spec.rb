require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:topic) { Topic.create(title: 'Test Topic', genre: 'Test Genre') }
  let(:post) { topic.posts.create(description: 'Test Post', topic: topic) }
  let!(:comment) { post.comments.create(content: 'Test Comment',post: post) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new comment' do
        initial_comment_count = Comment.count
        post :create, params: { topic_id: topic.id, post_id: post.id, comment: { content: 'New Comment Content' } }
        expect(Comment.count).to eq(initial_comment_count + 1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new comment' do
        initial_comment_count = Comment.count
        post :create, params: { topic_id: topic.id, post_id: post.id, comment: { content: nil } }
        expect(Comment.count).to eq(initial_comment_count)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the comment' do
      initial_comment_count = Comment.count
      delete :destroy, params: { topic_id: topic.id, post_id: post.id, id: comment.id }
      expect(Comment.count).to eq(initial_comment_count - 1)
    end
  end
end
