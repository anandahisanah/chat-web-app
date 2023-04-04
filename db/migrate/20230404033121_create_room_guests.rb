class CreateRoomGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :room_guests do |t|
      t.references :room, index: true, foreign_key: true
      t.references :guest, index: true, foreign_key: true

      t.timestamps
    end
  end
end
