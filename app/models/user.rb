class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :preferences

  validates :nickname, presence: true, uniqueness: true

  has_many :player_groups
  has_many :groups, through: :player_groups
  has_many :owned_groups, class_name: 'Group', as: :gm
end
