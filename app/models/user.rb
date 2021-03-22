class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :preferences

  # add validations and rspec
  validates :nickname, presence: true, uniqueness: true

  has_many :joined_groups, class_name: 'PlayerGroup', foreign_key: :joined_id
  has_many :owned_groups, class_name: 'Group', as: :gm, foreign_key: :owned_id
end
