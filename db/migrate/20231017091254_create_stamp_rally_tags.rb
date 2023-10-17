class CreateStampRallyTags < ActiveRecord::Migration[7.0]
  def change
    create_table :stamp_rally_tags do |t|
      t.references :stamp_rally, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
