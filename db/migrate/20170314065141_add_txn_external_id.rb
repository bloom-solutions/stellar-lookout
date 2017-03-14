class AddTxnExternalId < ActiveRecord::Migration[5.0]
  def change
    add_column :operations, :txn_external_id, :string, null: false
    add_foreign_key(:operations, :txns, {
      column: :txn_external_id,
      primary_key: :external_id,
    })
  end
end
