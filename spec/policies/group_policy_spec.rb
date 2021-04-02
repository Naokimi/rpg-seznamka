require 'rails_helper'

RSpec.describe GroupPolicy do
    let(:user)  { build(:user) }
    let(:group) { build(:group, gm: user) }
    subject { GroupPolicy.new(logged_user, group) }

  context 'self' do
    let(:logged_user) { user }
    it { should permit(:show) }
    it { should permit(:new) }
    it { should permit(:create) }
    it { should permit(:edit) }
    it { should permit(:update) }
    it { should permit(:destroy) }
  end

  context 'other' do
    let(:logged_user) { build(:user) }
    it { should permit(:show) }
    it { should permit(:new) }
    it { should permit(:create) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end
end
