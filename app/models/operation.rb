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

  scope :watched_by, ->(ward) do
    sql_parts = ADDRESS_FIELDS.map do |field|
      ["body ->> '#{field}' = ?", ward.address]
    end

    query = nil
    sql_parts.each do |sql_part|
      query = if query.nil?
                where(sql_part)
              else
                query.or(where(sql_part))
              end
    end
    query
  end

end
