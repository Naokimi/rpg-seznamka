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

    it 'with duplicated name' do
      create(:genre)
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

    let(:rulebook) { create(:rulebook, name: "rulebook") }
    let(:rulebook1) { create(:rulebook, name: "rulebook1") }
    let(:pairing) { create(:pairing, genre: subject, rulebook: rulebook) }
    let(:pairing1) { create(:pairing, genre: subject, rulebook: rulebook1) }

    it 'returns preferences of a genre' do
      expect(subject.preferences).to include(preference1)
      expect(subject.preferences).to include(preference2)
      expect(subject.preferences.length).to eq(2)
    end

    it "returns a genre's pairings" do
      expect(subject.pairings).to include(pairing)
      expect(subject.pairings).to include(pairing1)
      expect(subject.pairings.count).to eq(2)
    end

    it "returns genre's rulebooks" do
      subject.rulebooks << rulebook
      subject.rulebooks << rulebook1
      expect(subject.rulebooks).to include(rulebook)
      expect(subject.rulebooks).to include(rulebook1)
      expect(subject.rulebooks.size).to eq(2)
    end
  end
end
