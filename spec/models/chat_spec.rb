require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe "relation" do
    it { should belong_to(:user) }

  end

end
