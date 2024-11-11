require 'rails_helper'

RSpec.describe 'Devise routing', type: :routing do
  it 'routes /users/sign_in to devise/sessions#new' do
    expect(get: '/users/sign_in').to route_to('devise/sessions#new')
  end

  it 'routes /users/sign_out to devise/sessions#destroy' do
    expect(delete: '/users/sign_out').to route_to('devise/sessions#destroy')
  end

  it 'routes /users/password/new to devise/passwords#new' do
    expect(get: '/users/password/new').to route_to('devise/passwords#new')
  end

  it 'routes /users/password/edit to devise/passwords#edit' do
    expect(get: '/users/password/edit').to route_to('devise/passwords#edit')
  end

  it 'routes /users/password to devise/passwords#create' do
    expect(post: '/users/password').to route_to('devise/passwords#create')
  end

  it 'routes /users/password to devise/passwords#update' do
    expect(put: '/users/password').to route_to('devise/passwords#update')
  end
end