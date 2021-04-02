require 'rails_helper'

RSpec.describe UserPolicy do
  subject { UserPolicy.new(logged_user, user) }
  let(:logged_user) { build(:user) }

  context 'self' do
    let(:user) { logged_user }
    it { should permit(:show) }
    it { should permit(:edit) }
    it { should permit(:update) }
  end

  context 'other' do
    let(:user) { build(:user) }
    it { should permit(:show) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
  end

  context 'policy scope' do
    subject { Pundit.policy_scope!(logged_user, User) }

    before do
      create(:user)
      create(:user)
    end

    it { expect(subject.size).to eq(2) }
  end
end
