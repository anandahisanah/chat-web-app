require "test_helper"

class RoomGuestTest < ActiveSupport::TestCase
  test "find one" do
    assert_equal 1, room_guests(1).id
  end

  test "find all" do
    assert_equal 3, room_guests.length
  end

  test "find by id that does not exist" do
    assert_raise(StandardError) { room_guests(4) }
  end

  test "should not save room_guest without room_id and guest_id" do
    room_guest = RoomGuest.new
    assert_not room_guest.save, "Saved the room_guest without a room_id and guest_id"
  end

  test "should have room relation" do
    assert_equal 1, room_guests(1).room.id
  end

  test "should have guest relation" do
    assert_equal 1, room_guests(1).guest.id
  end
end
