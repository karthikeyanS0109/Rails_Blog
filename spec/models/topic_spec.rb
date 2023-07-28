# spec/models/topic_spec.rb

require 'rails_helper'

RSpec.describe Topic, type: :model do
  context "validations" do
    it "is valid with a title and genre" do
      topic = Topic.new(title: "Test Topic", genre: "Test Genre")
      expect(topic).to be_valid
    end

    it "is invalid without a title" do
      topic = Topic.new(genre: "Test Genre")
      expect(topic).to be_invalid
      expect(topic.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a genre" do
      topic = Topic.new(title: "Test Topic")
      expect(topic).to be_invalid
      expect(topic.errors[:genre]).to include("can't be blank")
    end
  end

  context "associations" do
    it "has many posts that are destroyed when the topic is destroyed" do
      topic = Topic.create(title: "Test Topic", genre: "Test Genre")
      post1 = Post.create(description: "Post 1", topic: topic)
      post2 = Post.create(description: "Post 2", topic: topic)
      expect(topic.posts).to include(post1)
      expect(topic.posts).to include(post2)
      topic.destroy
      expect(Post.find_by(id: post1.id)).to be_nil
      expect(Post.find_by(id: post2.id)).to be_nil
    end
  end
end
