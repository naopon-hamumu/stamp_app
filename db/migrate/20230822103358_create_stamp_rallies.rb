class CreateStampRallies < ActiveRecord::Migration[7.0]
  def change
    create_table :stamp_rallies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :image
      t.integer :visibility, null: false, default: 1

      t.timestamps
    end
  end
end
