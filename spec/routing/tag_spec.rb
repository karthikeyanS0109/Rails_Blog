require 'rails_helper'

RSpec.describe 'Tags routing', type: :routing do
  it 'tags#index' do
    expect(get: '/tags').to route_to('tags#index')
  end

  it 'tags#show' do
    expect(get: '/tags/1').to route_to('tags#show', id: '1')
  end

  it 'tags#new' do
    expect(get: '/tags/new').to route_to('tags#new')
  end

  it 'tags#edit' do
    expect(get: '/tags/1/edit').to route_to('tags#edit',id: '1')
  end

  it 'tags#create' do
    expect(post: '/tags').to route_to('tags#create')
  end

  it 'tags#update' do
    expect(patch: '/tags/1').to route_to('tags#update', id: '1')
  end

  it 'tags#update' do
    expect(put: '/tags/1').to route_to('tags#update', id: '1')
  end

  it 'tags#destroy' do
    expect(delete: '/tags/1').to route_to('tags#destroy',id: '1')
  end
end
