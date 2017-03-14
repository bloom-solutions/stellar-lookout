class CreateTxns < ActiveRecord::Migration[5.0]
  def change
    create_table :txns do |t|
      t.string :external_id, null: false
      t.integer :ledger_sequence, null: false
      t.jsonb :body
    end

    add_index :txns, :external_id, unique: true
    add_index :txns, :ledger_sequence
  end
end
