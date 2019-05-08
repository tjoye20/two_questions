class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :profile, foreign_key: true, index: true, null: false
      t.string :body, null: false
      t.string :state, null: false, default: :active
      t.string :uuid, index: true, null: false

      t.timestamps
    end
  end
end
