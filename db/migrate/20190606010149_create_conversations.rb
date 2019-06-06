class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :sender_id, index: true, null: false
      t.integer :recipient_id, index: true, null: false
      t.string :uuid, index: true, null: false
      t.timestamps
    end
  end
end
