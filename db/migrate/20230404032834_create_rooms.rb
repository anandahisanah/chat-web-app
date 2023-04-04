class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :owner, index: true, foreign_key: { to_table: :guests }

      t.timestamps
    end
  end
end
