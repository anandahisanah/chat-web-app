class Chat < ApplicationRecord
  has_one :room, :class_name => "Room", :foreign_key => "id"
  has_one :room_guest, :class_name => "RoomGuest", :foreign_key => "id"
  has_one :guest, :class_name => "Guest", :foreign_key => "id"

  validates :room_id, presence: true
  validates :room_guest_id, presence: true
  validates :guest_id, presence: true
  validates :remark, presence: true
end
