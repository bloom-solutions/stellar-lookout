FactoryGirl.define do

  factory :txn do
    sequence(:external_id) {|n| n}
    ledger
    body { {} }
  end

end
