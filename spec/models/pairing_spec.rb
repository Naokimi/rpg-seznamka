require 'rails_helper'

RSpec.describe Pairing, type: :model do
  subject { build(:pairing) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  context 'not valid' do
    it 'without a genre' do
      subject.genre = nil
      expect(subject).not_to be_valid
    end

    it 'without a rulebook' do
      subject.rulebook = nil
      expect(subject).not_to be_valid
    end

    it 'duplicated pairing' do
      pairing1 = create(:pairing)
      subject.genre = pairing1.genre
      subject.rulebook = pairing1.rulebook
      expect(subject).not_to be_valid
    end
  end

  context 'relations' do
    let(:genre) { create(:genre) }
    let(:rulebook) { create(:rulebook) }
    let(:pairing) { create(:pairing, genre: genre, rulebook: rulebook) }

    it "returns a pairing's genre" do
      expect(pairing.genre).to equal(genre)
    end

    it "returns a pairing's rulebook" do
      expect(pairing.rulebook).to equal(rulebook)
    end
  end
end
