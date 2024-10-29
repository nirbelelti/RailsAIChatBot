require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'relation' do
    it { should have_many(:chats) }
  end

end
