class Preference < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  validates :genre, uniqueness: { scope: :user }
end
