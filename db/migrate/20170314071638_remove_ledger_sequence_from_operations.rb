class RemoveLedgerSequenceFromOperations < ActiveRecord::Migration[5.0]
  def change
    remove_column :operations, :ledger_sequence, :integer, null: false
  end
end
