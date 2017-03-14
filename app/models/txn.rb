class Txn < ApplicationRecord

  has_many(:operations, {
    dependent: :destroy,
    primary_key: :external_id,
    foreign_key: :txn_external_id,
  })
  belongs_to :ledger, primary_key: :sequence, foreign_key: :ledger_sequence

  store_accessor :body, :operation_count

end
