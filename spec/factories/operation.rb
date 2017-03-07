FactoryGirl.define do

  factory :operation do
    sequence(:external_id) {|n| n}
    ledger
    body { {} }
  end

end
