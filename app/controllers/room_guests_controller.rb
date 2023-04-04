class RoomGuestsController < ApplicationController
  before_action :set_room_guest, only: %i[ show update destroy ]

  # GET /room_guests
  def index
    @room_guests = RoomGuest.all

    render json: @room_guests
  end

  # GET /room_guests/1
  def show
    render json: @room_guest
  end

  # POST /room_guests
  def create
    @room_guest = RoomGuest.new(room_guest_params)

    if @room_guest.save
      render json: @room_guest, status: :created, location: @room_guest
    else
      render json: @room_guest.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /room_guests/1
  def update
    if @room_guest.update(room_guest_params)
      render json: @room_guest
    else
      render json: @room_guest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /room_guests/1
  def destroy
    @room_guest.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_guest
      @room_guest = RoomGuest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_guest_params
      params.fetch(:room_guest, {})
    end
end
