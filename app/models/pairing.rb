class Pairing < ApplicationRecord
  belongs_to :genre
  belongs_to :rulebook

  validates :rulebook, uniqueness: { scope: :genre }
end
