class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :uuid, index: true, null: false
      t.references :user, foreign_key: true, index: true, null: false
      t.integer :gender, null: false
      t.integer :gender_seeking, null: false
      t.text :bio, null: false
      t.integer :race, null: false
      t.string :location, null: false
      t.string :images, array: true, default: []

      t.timestamps
    end
  end
end
