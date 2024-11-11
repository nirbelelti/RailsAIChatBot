require 'rails_helper'

RSpec.describe '/chats', type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) {
    { question: 'Hello', user_id: user.id }
  }

  let(:invalid_attributes) {
    { question: '', user_id: user.id }
  }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Chat.create! valid_attributes
      get chats_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      chat = Chat.create! valid_attributes
      get chat_url(chat)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_chat_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      chat = Chat.create! valid_attributes
      get edit_chat_url(chat)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Chat' do
        expect {
          post chats_url, params: { chat: valid_attributes }
        }.to change(Chat, :count).by(1)
      end
    end
  end

end
