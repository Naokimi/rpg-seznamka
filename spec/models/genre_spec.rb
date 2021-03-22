require 'rails_helper'

RSpec.describe Genre, type: :model do
  subject { build(:genre) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  context 'not valid' do
    it 'without a name' do
      subject.name = nil
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
  end

  context 'relations' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:preference1) { create(:preference, user: user1, genre: subject) }
    let(:preference2) { create(:preference, user: user2, genre: subject) }
    let(:rulebook) { create(:rulebook, genre: subject) }

    it 'returns preferences of a genre' do
      expect(subject.preferences).to include(preference1)
      expect(subject.preferences).to include(preference2)
      expect(subject.preferences.length).to eq(2)
    end

    it 'returns rulebooks of a genre' do
      rulebook2 = create(:rulebook, name: 'test', genre: subject)
      expect(subject.rulebooks).to include(rulebook)
      expect(subject.rulebooks).to include(rulebook2)
      expect(subject.rulebooks.length).to eq(2)
    end
  end
end
