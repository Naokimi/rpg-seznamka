class Group < ApplicationRecord
  belongs_to :gm, class_name: "User"
  has_many :player_groups
  has_many :users, through: :player_groups
  # geocoded_by :city

  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :description, presence: true, length: { in: 10..500, message: 'Must be between 10 and 500 characters.' }
end
