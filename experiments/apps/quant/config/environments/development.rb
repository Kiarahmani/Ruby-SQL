Quantify::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  config.middleware.use Rack::LiveReload
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = { :host => "localhost:3000" }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Expands the lines which load the assets
  config.assets.debug = false

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    :address              => Settings.smtp_address,
    :port                 => Settings.smtp_port,
    :domain               => Settings.smtp_domain,
    :user_name            => Settings.smtp_user_name,
    :password             => Settings.smtp_password,
    :authentication       => Settings.smtp_authentication,
    :enable_starttls_auto => true }
end