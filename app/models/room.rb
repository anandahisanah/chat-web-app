class Room < ApplicationRecord
  # belongs_to :room_guest
  # belongs_to :chat

  has_one :owner, :class_name => "Guest", :foreign_key => "id"
  
  validates :owner_id, presence: true
  validates :name, presence: true
end
