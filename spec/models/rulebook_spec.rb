require 'rails_helper'

RSpec.describe Rulebook, type: :model do
  subject { build(:rulebook) }

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

    it 'without an image' do
      subject.img_url = nil
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
  end
end
