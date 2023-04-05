class AddGuestNameAtChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :guest_name, :string
  end
end
