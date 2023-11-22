require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

#追記
require 'capybara/rspec'

# カスタムのモジュールを読み込む
require_relative './support/login_module'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec/fixtures')
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # letを使用したときに、FactoryBotが使用できるように設定
  config.include FactoryBot::Syntax::Methods
  # module読み込み
  config.include LoginModule
end
