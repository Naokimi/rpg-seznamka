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
    let(:rulebook) { create(:rulebook, genre: genre) }

    it "returns a rulebooks's genre" do
      expect(rulebook.genre).to equal(genre)
    end

    # TODO: uncomment after adding rulebook_id to group
    # it "returns a rulebook's groups" do
      # group1 = create(:group, rulebook: rulebook)
      # group2 = create(:group, rulebook: rulebook)
      # expect(rulebook.groups).to include(group1)
      # expect(rulebook.groups).to include(group2)
      # expect(rulebook.groups.length).to equal(2)
    # end
  end
end
