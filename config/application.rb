require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Apps
  class Application < Rails::Application
    config.load_defaults 6.0
    
    # タイムゾーンとロケールの設定
    config.time_zone = "Tokyo"
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb.yml}").to_s]
    config.i18n.default_locale = :ja
  
    # generatorコマンド実行時の自動生成ファイルを制限する
    config.generators do |g|
      g.skip_routes       true
      g.helper            false
      g.assets            false
      g.test_framework    :rspec
      g.controller_specs  false
      g.view_spaces       false
    end
  end
end
