require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'inifile'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Karitakke
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true


    def _get(inifile, section, name)
      begin
        return inifile[section][name]
      rescue => e
        return "error: could not read #{name}"
      end
    end

    keys = ['your_tag', 'your_key_id', 'your_key'] # 格納先
    keyfile = "config/secret_key.dat" # 外部ファイル名

    if File.exist?(keyfile) then
      inifile = IniFile.load(keyfile)
      keys[0] = _get(inifile, "amazon", 'associate_tag')
      keys[1] = _get(inifile, "amazon", 'AWS_access_key_id')
      keys[2] = _get(inifile, "amazon", 'AWS_secret_key')
    end

    Amazon::Ecs.options = {
      :associate_tag =>     keys[0],
      :AWS_access_key_id => keys[1],
      :AWS_secret_key =>    keys[2]
    }

  end
end
