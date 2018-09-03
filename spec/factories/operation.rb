FactoryBot.define do

  factory :operation do
    sequence(:external_id) {|n| n}
    txn
    body { {} }
  end

end
