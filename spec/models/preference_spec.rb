require 'rails_helper'

RSpec.describe Preference, type: :model do
  subject { build(:preference) }

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

    it 'without a genre' do
      subject.genre = nil
      expect(subject).not_to be_valid
    end

    it 'duplicated' do
      preference = create(:preference)
      subject.user_id = preference.user_id
      subject.genre_id = preference.genre_id
      expect(subject).not_to be_valid
    end
  end

  context 'relations' do
    let(:user) { create(:user) }
    let(:genre) { create(:genre) }
    let(:preference) { create(:preference, user: user, genre: genre) }

    it "returns a preference's user" do
      expect(preference.user).to equal(user)
    end

    it "returns a preference's genre" do
      expect(preference.genre).to equal(genre)
    end
  end
end
