RSpec.configure do |c|
  c.before do |example|
    if %i[request].include?(example.metadata[:type])
      ActiveJob::Base.queue_adapter = :test
    else
      ActiveJob::Base.queue_adapter = :test
    end
  end
end
