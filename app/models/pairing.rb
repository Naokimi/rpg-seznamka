class Pairing < ApplicationRecord
  belongs_to :genre
  belongs_to :rulebook

  validates :genre, presence: true
  validates :rulebook, presence: true, uniqueness: { scope: :genre }
end
