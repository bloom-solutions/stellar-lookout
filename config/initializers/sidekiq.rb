Sidekiq.configure_server do |config|
  Sidekiq::Cron::Job.destroy_all!

  Sidekiq.default_worker_options = {
    lock: :until_executing,
    unique_args: ->(args) { [ args.first.except('job_id') ] }
  }

  Dir[Rails.root.join("config", "schedules", "*.yml")].each do |file|
    var_name = Pathname.new(file).basename(".*").to_s.upcase
    if ENV[var_name] != "false"
      Sidekiq::Cron::Job.load_from_hash(YAML.load_file(file))
    end
  end
end
