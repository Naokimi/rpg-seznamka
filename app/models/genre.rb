class Genre < ApplicationRecord
  has_many :preferences
  has_many :pairings
  has_many :rulebooks, through: :pairings

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { in: 10..500, message: 'Must be between 10 and 500 characters.' }
end
