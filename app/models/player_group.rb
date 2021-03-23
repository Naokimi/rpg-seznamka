class PlayerGroup < ApplicationRecord
  belongs_to :users
  belongs_to :groups
end
