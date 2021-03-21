require 'rails_helper'

RSpec.describe Genre, type: :model do
  subject { build(:genre) }

  it 'has a valid description length' do
    subject.description = 'Test description'
    expect(subject.description.length).to be_between(10, 500)
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
  end
end
