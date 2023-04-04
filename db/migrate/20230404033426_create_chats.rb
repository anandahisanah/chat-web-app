class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.references :room, index: true, foreign_key: true
      t.references :room_guest, index: true, foreign_key: true
      t.references :guest, index: true, foreign_key: true
      t.text :remark, null: false

      t.timestamps
    end
  end
end
