class Ledger < ActiveRecord::Base

  has_many(:txns, {
    primary_key: :sequence,
    foreign_key: :ledger_sequence,
    dependent: :destroy,
  })
  has_many :operations, through: :txns

  store_accessor :body, :transaction_count, :operation_count, :paging_token

  scope :sequence_before, ->(sequence) do
    where(arel_table[:sequence].lt(sequence))
  end

end
