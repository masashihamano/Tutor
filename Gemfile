source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'
gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'sdoc', '~> 0.4.0', group: :doc

# pryとconsoleが使用可能
gem 'pry-rails'
gem 'pry-doc'
# byebugが使える(next)
gem 'pry-byebug'
# frame [数字]でコンテキスト移動できる
gem 'pry-stack_explorer'
# bootstrapの導入
gem 'bootstrap-sass'
# jqueryの導入(bootstrapに必要)
gem 'jquery-rails'
# ログイン機能を簡単に作成
gem 'devise'
# flash機能
gem 'toastr-rails'
# facebookログイン機能
gem 'omniauth-facebook'
# ファイルをアップロードする機能
gem "paperclip", "~> 6.0.0"
# ドラッグ & ドロップによるファイルアップロード機能
gem 'dropzonejs-rails'
# gitにupした時のkey情報を暗号化する(config/locales/application.yml)と(devise.rb)
gem "figaro", "~> 1.1.0"



# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false


# 本番環境
group :production do
  # PostgreSQLにアクセスするためのライブラリ
  gem 'pg', '~> 0.20.0'
  # Herokuを本番環境のサーバ上で動かす機能
  gem 'rails_12factor'
end

# 開発環境/テスト環境
group :development, :test do
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
