class Preference < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  validates :user, presence: true
  validates :genre, presence: true
end
