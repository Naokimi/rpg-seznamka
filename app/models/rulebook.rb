class Rulebook < ApplicationRecord
  has_many :pairings
  has_many :genres, through: :pairings
  has_many :groups

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { in: 10..3000, message: 'Must be between 10 and 3000 characters.' }
  validates :img_url, presence: true, format: { with: /\.(png|jpg|jpeg|svg)\Z/i }
end
