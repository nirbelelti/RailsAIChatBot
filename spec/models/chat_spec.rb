require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
  end
  describe 'Validations' do
    it { should validate_presence_of(:history).on(:update) }
  end

end
