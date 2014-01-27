require File.expand_path('../boot', __FILE__)

require 'wagn/all'

module MySite
  class Application < Wagn::Application
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    cache_store = ( Wagn::Conf[:cache_store] || :file_store ).to_sym
    cache_args = case cache_store
      when :file_store
        Wagn::Conf[:file_store_dir] || "#{Rails.root}/tmp/cache"
      when :mem_cache_store, :dalli_store
        Wagn::Conf[:mem_cache_servers] || []
      end
    config.cache_store = cache_store, *cache_args

    # Custom directories with classes and modules you want to be autoloadable.


  end
end
