class Operation < ActiveRecord::Base

  ADDRESS_FIELDS = %i[
    asset_issuer
    buying_asset_issuer
    from
    funder
    into
    selling_asset_issuer
    send_asset_issuer
    source_account
    to
    trustee
    trustor
  ]

  belongs_to(:ledger, {
    primary_key: :sequence,
    foreign_key: "ledger_sequence",
  })

end
