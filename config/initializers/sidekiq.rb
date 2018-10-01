Sidekiq.configure_server do |config|
  config.poll_interval = 10

  Sidekiq::Cron::Job.destroy_all!

  Sidekiq.default_worker_options = {
    lock: :until_executing,
    unique_args: ->(args) { [ args.first.except('job_id') ] }
  }

  config.death_handlers << ->(job, _ex) do
    SidekiqUniqueJobs::Digests.del(digest: job['unique_digest']) if job['unique_digest']
  end

  Dir[Rails.root.join("config", "schedules", "*.yml")].each do |file|
    var_name = Pathname.new(file).basename(".*").to_s.upcase
    if ENV[var_name] != "false"
      Sidekiq::Cron::Job.load_from_hash(YAML.load_file(file))
    end
  end
end
