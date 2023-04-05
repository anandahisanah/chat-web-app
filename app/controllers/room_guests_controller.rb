class RoomGuestsController < ApplicationController
  # POST /room_guests
  def create
    @room_guest = RoomGuest.new(room_guest_params)

    if @room_guest.save
      render json: {
        status: "success",
        room_guest: @room_guest,
      }, status: :created, location: @room_guest
    else
      render json: @room_guest.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def room_guest_params
    # params.permit(:id, :room_id, :guest_id)
    params.require(:room_guest).permit(:id, :room_id, :guest_id)
  end
end
