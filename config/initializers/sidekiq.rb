Sidekiq.configure_server do |config|
  Sidekiq::Cron::Job.destroy_all!

  schedule_file = Rails.root.join("config", "schedule.yml")

  if File.exists?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end
