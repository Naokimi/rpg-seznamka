class Rulebook < ApplicationRecord
  belongs_to :genre
  # has_many :groups

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { in: 10..500, message: 'Must be between 10 and 500 characters.' }
end
