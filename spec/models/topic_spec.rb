require 'rails_helper'

RSpec.describe Topic, type: :model do
  it"is valid with title and genre" do
    topic=Topic.new(title: "Black Clover",genre: "Fantasy")
    expect(topic).to be_valid
  end
  
  it"is invalid without title" do
    topic=Topic.new(genre: "Fantasy")
    expect(topic).not_to be_valid
  end

  it"is invalid without genre" do
    topic=Topic.new(title: "Black Clover")
    expect(topic).not_to be_valid
  end
end
