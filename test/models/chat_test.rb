require "test_helper"

class ChatTest < ActiveSupport::TestCase
  test "find one" do
    assert_equal 1, chats(1).id
  end

  test "find all" do
    assert_equal 5, chats.length
  end

  test "find by id that does not exist" do
    assert_raise(StandardError) { chats(6) }
  end

  test "should not save room without room_id, room_guest_id, guest_id and remark" do
    chat = Chat.new
    assert_not chat.save, "Saved the room without a room_id, room_guest_id, guest_id and remark"
  end

  test "should have room relation" do
    assert_equal 1, chats(1).room.id
  end

  test "should have room_guest relation" do
    assert_equal 1, chats(1).room_guest.id
  end

  test "should have guest relation" do
    assert_equal 1, chats(1).guest.id
  end
end
