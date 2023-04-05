class RoomGuest < ApplicationRecord
  # belongs_to :room
  # belongs_to :chat

  has_one :room, :class_name => "Room", :foreign_key => "id"
  has_one :guest, :class_name => "Guest", :foreign_key => "id"

  validates :room_id, presence: true
  validates :guest_id, presence: true
end
