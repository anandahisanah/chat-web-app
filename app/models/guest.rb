class Guest < ApplicationRecord
  has_many :rooms
  validates :name, presence: true
end
