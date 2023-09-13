class CreateStamps < ActiveRecord::Migration[7.0]
  def change
    create_table :stamps do |t|
      t.references :stamp_rally, null: false, foreign_key: true
      t.string :name, null: false
      t.string :sticker, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
