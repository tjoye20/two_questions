class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uuid, null: false, index: true
      t.string :email, null: false, index: true
      t.text :image
      t.string :display_name
      t.string :state, default: :active 

      t.timestamps
    end
  end
end
