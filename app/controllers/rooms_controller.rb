class RoomsController < ApplicationController
  # GET /rooms
  def index
    @rooms = Room.all

    render json: @rooms
  end

  # GET /rooms/1
  def show
    @room = Room.find(params[:id])
    render json: @room
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)

    if @room.save
      render json: {
        status: "success",
        room: @room,
      }, status: :created, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:id, :owner_id, :name)
  end
end
