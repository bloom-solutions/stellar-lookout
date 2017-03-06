class CreateOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.string :external_id, null: false
      t.integer :ledger_sequence, null: false, foreign_key: true
      t.jsonb :body, null: false, default: {}.to_json
      Operation::ADDRESS_FIELDS.each do |field|
        t.index("((body ->> '#{field}'::text))", name: "operations_#{field}", using: :btree)
      end
      t.index ["external_id"], name: "index_operations_on_external_id", unique: true, using: :btree
    end
  end
end
