FactoryBot.define do

  factory :ward do
    address { "GAT6VDPXX26XXFAKACUJTIZAL3GSFJ4NECG7B3C3P63IP4233XFP2PCS" }
    sequence(:callback_url) {|n| "https://domain.com/cb#{n}" }
    secret { SecureRandom.uuid }
  end

end
