module Surveying
  class InitClient

    extend LightService::Action
    expects :ward
    promises :body

    executed do |c|
      uri = URI(ENV["HORIZON_URL"])
      uri.path = "/ledgers"
      client = Hyperclient.new(uri.to_s) do |c|
        c.options[:async] = false
      end
      binding.pry
      ledger_records = client.records
      while ledger_records.any?
        ledger_records.each do |ledger_record|
          operation_records = if ledger_record["operation_count"].zero?
                                []
                              else
                                ["fetched from #{record["id"]}"]
                              end
        end
      end

      # operations = client.account(account_id: c.ward.address).operations
      # operation_records = operations.records
      # while operation_records.any?
      #   operation_records.each do |op_record|
      #     puts op_record.to_h
      #   end
      #   operations = operations._links.next
      #   puts "Next: #{operations}"
      #   binding.pry
      #   operation_records = operations.records
      # end
      #
      # client = Hyperclient.new("https://grape-with-roar.herokuapp.com/api") do |c|
      #   c.options[:async] = false
      # end
      # splines = client.splines
      # while splines
      #   splines._embedded.splines.each do |spline|
      #     puts spline['uuid']
      #   end
      #   splines = splines._links.next
      # end
    end

  end
end
