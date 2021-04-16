class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  serialize :availability, HashSerializer

  has_many :preferences
  has_many :genres, through: :preferences

  validates :nickname, presence: true, uniqueness: true

  has_many :player_groups
  has_many :groups, through: :player_groups
  has_many :owned_groups, class_name: 'Group', foreign_key: :gm_id, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def availability_to_rows
    # e.g.: Mo [0,1,2], Tu [0,1,2] => [[1,1,0,0,0,0,0], [1,1,0,0,0,0,0], [1,1,0,0,0,0,0], [0,0,0,0,0,0,0]...]
    availability.values.map { |slots| (0..23).to_a.map { |hour| slots.include?(hour) ? 1 : 0 } }.transpose
  end
end
