class GuestsController < ApplicationController
  # GET /guests
  def index
    @guests = Guest.all

    render json: @guests
  end

  # GET /guests/1
  def show
    @guest = Guest.find(params[:id])
    render json: @guest
  end

  # POST /guests
  def create
    @guest = Guest.new(guest_params)

    if @guest.save
      render json: {
        status: "success",
        guest: @guest,
      }, status: :created, location: @guest
    else
      render json: @guest.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def guest_params
    params.require(:guest).permit(:id, :name)
  end
end
