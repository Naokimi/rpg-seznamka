require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  context 'not valid' do
    it 'without a nickname' do
      subject.nickname = nil
      expect(subject).not_to be_valid
    end

    it 'without an email' do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it 'without a password' do
      subject.password = nil
      expect(subject).not_to be_valid
    end
  end
end
