class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.references :profile, foreign_key: true, index: true, null: false
      t.string :uuid, null: false, index: true
      t.string :state, null: false, default: :new

      t.timestamps
    end
  end
end
