FactoryBot.define do

  factory :ledger do
    external_id { SecureRandom.hex }
    sequence(:sequence) { |n| n }
  end

end
