class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :uuid, index: true, null: false
      t.belongs_to :conversation, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.text :body
      
      t.timestamps
    end
  end
end
