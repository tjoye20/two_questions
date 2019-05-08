class CreateViews < ActiveRecord::Migration[5.2]
  def change
    create_table :views do |t|
      t.references :profile, foreign_key: true, index: true, null: false
      t.references :user, foreign_key: true, index: true, null: false
      t.string :state, null: false

      t.timestamps
    end
  end
end
