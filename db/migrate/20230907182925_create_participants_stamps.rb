class CreateParticipantsStamps < ActiveRecord::Migration[7.0]
  def change
    create_table :participants_stamps do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :stamp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
