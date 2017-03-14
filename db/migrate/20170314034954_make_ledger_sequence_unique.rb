class MakeLedgerSequenceUnique < ActiveRecord::Migration[5.0]
  def change
    remove_index :ledgers, :sequence
    add_index :ledgers, :sequence, unique: true
  end
end
