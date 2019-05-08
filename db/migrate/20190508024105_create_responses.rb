class CreateResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.references :question, foreign_key: true, index: true, null: false
      t.text :body, null: false
      t.string :uuid, null: false, index: true

      t.timestamps
    end
  end
end
