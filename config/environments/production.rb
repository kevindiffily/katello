# workaround for https://github.com/nex3/sass/issues/69
require 'sass/plugin'

Src::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :warn)
  config.colorize_logging = false

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  config.assets.precompile << Proc.new { |path|
    if path =~ /\.(css|js)\z/
      full_path = Rails.application.assets.resolve(path).to_path
      app_assets_path = Rails.root.join('app', 'assets').to_path
      if full_path.starts_with? app_assets_path
        puts "including asset: " + full_path
        true
      else
        puts "excluding asset: " + full_path
        false
      end
    else
      false
    end
  }

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  config.threadsafe! if defined? JRUBY_VERSION

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Be sure to restart your server when you modify this setting.
  config.session_store ::Katello::UrlConstrainedCookieStore,
    :key => '_katello_session', :expire_after => 1.hour, :expiration_exceptions => "/notices"

  # Do not update compass SASS files in production (we precompile them)
  Sass::Plugin.options[:never_update] = true
end
