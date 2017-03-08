class Ledger < ActiveRecord::Base

  has_many(:operations, {
    primary_key: :sequence,
    foreign_key: :ledger_sequence,
    dependent: :destroy,
  })

  store_accessor :body, :operation_count, :paging_token

end
