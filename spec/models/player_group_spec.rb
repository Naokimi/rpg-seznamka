require 'rails_helper'

RSpec.describe PlayerGroup, type: :model do
  subject { build(:player_group) }

  context 'relations' do
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    it 'returns a user in a playergroup belongs_to' do
      subject.user_id = user.id
      expect(subject.user_id).to equal(user.id)
    end

    it 'returns a group a playergroup belongs_to' do
      subject.group_id = group.id
      expect(subject.group_id).to equal(group.id)
    end
  end
end
