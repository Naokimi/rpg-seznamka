require 'rails_helper'

RSpec.describe PlayerGroup, type: :model do
  subject { build(:player_group) }

  context 'valid' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end
  end

  context 'not valid' do
    it 'without a user' do
      subject.user = nil
      expect(subject).not_to be_valid
    end

    it 'without a group' do
      subject.group = nil
      expect(subject).not_to be_valid
    end

    it 'duplicated' do
      player_group = create(:player_group)
      subject.user_id = player_group.user_id
      subject.group_id = player_group.group_id
      expect(subject).not_to be_valid
    end
  end

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
