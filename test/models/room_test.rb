require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test "find one" do
    assert_equal 1, rooms(1).id
  end

  test "find all" do
    assert_equal 2, rooms.length
  end

  test "find by id that does not exist" do
    assert_raise(StandardError) { rooms(3) }
  end

  test "should not save room without owner_id and name" do
    room = Room.new
    assert_not room.save, "Saved the room without a owner_id and name"
  end

  test "should have owner relation" do
    assert_equal 1, rooms(1).owner.id
  end
end
