class CreateLedgers < ActiveRecord::Migration[5.0]
  def change
    create_table :ledgers do |t|
      t.string :external_id, index: true
      t.integer :sequence, null: false, index: true, unique: true
      t.jsonb :body, default: {}, null: false
      t.timestamps
    end
  end
end
