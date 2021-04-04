require 'rails_helper'

RSpec.describe Rulebook, type: :model do
  subject { build(:rulebook) }

  context 'valid' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end

    it 'has a valid JPEG image format' do
      subject.img_url = 'myImgUrl.jpeg'
      expect(subject).to be_valid
    end

    it 'has a valid PNG image format' do
      subject.img_url = 'myImgUrl.png'
      expect(subject).to be_valid
    end

    it 'has a valid SVG image format' do
      subject.img_url = 'myImgUrl.svg'
      expect(subject).to be_valid
    end
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

    it 'without an image' do
      subject.img_url = nil
      expect(subject).not_to be_valid
    end

    it 'without valid image format' do
      subject.img_url = 'myImgUrl.jp'
      expect(subject).not_to be_valid
    end

    it 'description too short' do
      subject.description = 'test'
      expect(subject).not_to be_valid
    end

    it 'duplicated' do
      rulebook = create(:rulebook)
      subject.name = rulebook.name
      expect(subject).not_to be_valid
    end
  end

  context 'relations' do
    let(:genre) { create(:genre) }
    let(:genre2) { create(:genre, name: "genre") }
    let(:pairing) { create(:pairing, genre: genre, rulebook: subject) }
    let(:pairing2) { create(:pairing, genre: genre2, rulebook: subject) }

    it "returns a rulebooks's pairings" do
      expect(subject.pairings).to include(pairing)
      expect(subject.pairings).to include(pairing2)
      expect(subject.pairings.count).to eq(2)
    end

    it "returns a rulebook's genres" do
      subject.genres << genre
      subject.genres << genre2
      expect(subject.genres).to include(genre)
      expect(subject.genres).to include(genre2)
      expect(subject.genres.size).to eq(2)
    end

    it "returns a rulebook's groups" do
      group1 = create(:group, rulebook: subject)
      group2 = create(:group, name: 'group2', rulebook: subject)
      expect(subject.groups).to include(group1)
      expect(subject.groups).to include(group2)
      expect(subject.groups.length).to equal(2)
    end
  end
end
