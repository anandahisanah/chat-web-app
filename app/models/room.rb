class Room < ApplicationRecord
  validates :owner_id, presence: true
end
