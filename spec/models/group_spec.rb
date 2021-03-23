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
      let(:user) { create(:user) }
      let(:group) { create(:group, gm: user) }

      it "returns a group's gm" do
        expect(group.gm).to equal(user)
      end
    end
  end
end
