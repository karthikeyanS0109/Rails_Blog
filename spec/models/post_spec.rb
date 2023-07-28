# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it "is valid with a description and topic" do
      topic = Topic.create(title: "Test Topic", genre: "Test Genre")
      post = Post.new(description: "Test Post", topic: topic)
      expect(post).to be_valid
    end

    it "is invalid without a description" do
      topic = Topic.create(title: "Test Topic", genre: "Test Genre")
      post = Post.new(topic: topic)
      expect(post).to be_invalid
    end

    it "is invalid without a topic" do
      post = Post.new(description: "Test Post")
      expect(post).to be_invalid
    end
  end

  describe "associations" do
    it "belongs to a topic" do
      topic = Topic.create(title: "Test Topic", genre: "Test Genre")
      post = Post.new(description: "Test Post", topic: topic)
      expect(post.topic).to eq(topic)
    end

    it "is destroyed when the associated topic is destroyed" do
      topic = Topic.create(title: "Test Topic", genre: "Test Genre")
      post = Post.create(description: "Test Post", topic: topic)

      expect { topic.destroy }.to change(Post, :count).by(-1)
    end
  end
end
