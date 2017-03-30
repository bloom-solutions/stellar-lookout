Sidekiq.configure_server do |config|
  Sidekiq::Cron::Job.destroy_all!

  Dir[Rails.root.join("config", "schedules", "*.yml")].each do |file|
    var_name = Pathname.new(file).basename(".*").to_s.upcase
    if ENV[var_name] != "false"
      Sidekiq::Cron::Job.load_from_hash(YAML.load_file(file))
    end
  end
end
