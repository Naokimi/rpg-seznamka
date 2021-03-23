require 'rails_helper'

RSpec.describe Group, type: :model do
  subject { build(:group) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  context 'not valid' do
    it 'without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'with duplicated name' do
      create(:group)
      expect(subject).not_to be_valid
    end

    it 'without a description' do
      subject.description = nil
      expect(subject).not_to be_valid
    end

    it 'description too short' do
      subject.description = 'test'
      expect(subject).not_to be_valid
    end

    it 'without a city' do
      subject.city = nil
      expect(subject).not_to be_valid
    end

    context 'relations' do
      let(:game_master) { create(:user) }
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let(:group) { create(:group, gm: game_master) }
      let(:playergroup) { create(:player_group, group: group, user: user1) }

      it "returns a group's gm" do
        group.gm = game_master
        expect(group.gm).to equal(game_master)
      end

      it "returns a group's users" do
        puts group.users
        # expect(group.users).to include(user1)
      end
    end
  end
end
