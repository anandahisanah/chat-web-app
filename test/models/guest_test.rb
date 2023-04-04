require "test_helper"

class GuestTest < ActiveSupport::TestCase
  test "find one" do
    assert_equal 1, guests(1).id
  end

  test "find all" do
    assert_equal 3, guests.length
  end

  test "find by id that does not exist" do
    assert_raise(StandardError) { guests(4) }
  end

  test "should not save guest without name" do
    guest = Guest.new
    assert_not guest.save, "Saved the guest without a name"
  end  
end
