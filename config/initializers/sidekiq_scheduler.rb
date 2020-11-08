require 'sidekiq/scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    config_path = Rails.root.join('config', 'sidekiq_scheduler.yml').to_s

    Sidekiq.schedule = YAML.load_file(config_path)
    Sidekiq::Scheduler.reload_schedule!
  end
end