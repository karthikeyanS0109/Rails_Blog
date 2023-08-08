require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:topic) { Topic.create(title: 'Test Topic', genre: 'Test genre') }
  let(:post) { topic.posts.create(description: 'Test Post') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      comment = Comment.new(content: 'Test Comment')
      comment.post = post
      expect(comment).to be_valid
    end

    it 'is not valid without content' do
      comment = Comment.new
      comment.post = post
      expect(comment).to_not be_valid
      expect(comment.errors[:content]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to a post' do
      comment = Comment.new(content: 'Test Comment')
      comment.post = post
      comment.save

      expect(comment.post).to eq(post)
    end
  end
end
