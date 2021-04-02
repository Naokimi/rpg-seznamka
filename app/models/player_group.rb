class PlayerGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group, uniqueness: { scope: :user }
end
