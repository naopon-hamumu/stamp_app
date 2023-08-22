class CreateSnsCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :sns_credentials do |t|
      t.string :provider, null: false
      t.string :uid, nul: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
