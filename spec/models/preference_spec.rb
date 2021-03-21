require 'rails_helper'

RSpec.describe Preference, type: :model do
  subject { build(:preference) }

  it 'has a valid factory' do
    expect(subject).to be_valid
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
  end
end
