require "cgi"

class ChatsController < ApplicationController
  # GET /chats
  def index
    url = request.original_url
    uri = URI.parse(url)
    params = CGI.parse(uri.query)
    room_id = params["room_id"].first
    @chat = Chat.where(room_id: room_id)

    render json: @chat
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: {
        status: "success",
        chat: @chat,
      }, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def chat_params
    params.require(:chat).permit(:id, :room_id, :room_guest_id, :guest_id, :guest_name, :remark)
  end
end
