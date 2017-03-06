class Ward < ActiveRecord::Base

  scope :watching, ->(operation) do
    body = JSON.parse(operation.body).with_indifferent_access
    addresses = Operation::ADDRESS_FIELDS.map { |field| body[field] }.compact
    where(address: addresses)
  end

end
