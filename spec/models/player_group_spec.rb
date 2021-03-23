# require 'rails_helper'

# RSpec.describe PlayerGroup, type: :model do
#   subject { build(:player_group) }

#   context 'relations' do
#     let(:user1) { create(:user) }
#     let(:user2) { create(:user) }
#     let(:group1) { create(:group) }
#     let(:group2) { create(:group) }

#     # let(:playergroup) { create(subject, user: user, group: group) }

#     it "returns a playergroup's users" do
#       expect(subject.user).to include(user1)
#       expect(subject.user).to include(user2)
#       expect(subject.user.length).to eq(2)
#     end

#     it "returns a playergroup's groups" do
#       expect(subject.groups).to include(group1)
#       expect(subject.groups).to include(group2)
#       expect(subject.groups.length).to eq(2)
#     end
#   end

# end


# # context 'relations' do
# #     let(:user1) { create(:user) }
# #     let(:user2) { create(:user) }
# #     let(:preference1) { create(:preference, user: user1, genre: subject) }
# #     let(:preference2) { create(:preference, user: user2, genre: subject) }
# #     let(:rulebook) { create(:rulebook, genre: subject) }
# #     it 'returns preferences of a genre' do
# #       expect(subject.preferences).to include(preference1)
# #       expect(subject.preferences).to include(preference2)
# #       expect(subject.preferences.length).to eq(2)
# #     end
# #     it 'returns rulebooks of a genre' do
# #       rulebook2 = create(:rulebook, name: 'test', genre: subject)
# #       expect(subject.rulebooks).to include(rulebook)
# #       expect(subject.rulebooks).to include(rulebook2)
# #       expect(subject.rulebooks.length).to eq(2)
# #     end
