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

      it "returns a group's gm" do
        subject.gm = game_master
        expect(subject.gm).to equal(game_master)
      end

      it "returns a group's users" do
        playergroup1 = create(:player_group, group: subject, user: user1)
        playergroup2 = create(:player_group, group: subject, user: user2)
        expect(subject.users).to include(user1)
        expect(subject.users).to include(user2)
        expect(subject.users.length).to equal(2)
      end

      it "returns a group's rulebook" do
        rulebook = create(:rulebook)
        subject.rulebook = rulebook
        expect(subject.rulebook).to equal(rulebook)
      end
    end
  end
end
