class Ward < ActiveRecord::Base

  has_many :reports, dependent: :destroy

  scope :watching, ->(operation) do
    addresses = Operation::ADDRESS_FIELDS.map do |field|
      operation.body[field.to_s]
    end.compact
    where(address: addresses)
  end

end
