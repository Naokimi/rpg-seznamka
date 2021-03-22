class Group < ApplicationRecord
  belongs_to :gm, class_name: "User", foreign_key: :gm_id
  has_many :player_groups
  has_many :users, through: :player_groups

  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :description, presence: true, length: { in: 10..500, message: 'Must be between 10 and 500 characters.' }
end
