require 'rails_helper'

RSpec.describe 'Comment routing', type: :routing do
  it 'comments#create' do
    expect(post: '/topics/1/posts/2/comments').to route_to("comments#create", topic_id: '1', post_id: '2')
  end

  it 'comments#destroy' do
    expect(delete: '/topics/1/posts/2/comments/3').to route_to("comments#destroy", topic_id: '1', post_id: '2', id: '3')
  end
end
