source 'http://rubygems.org'

gem 'rake', '0.9.2'
gem 'rails', '3.1.0.rc6'
gem 'mysql2', '0.3.7'

gem 'haml', '3.1.2'
gem 'compass', '0.11.5'
gem 'jquery-rails', '1.0.3'
gem 'simple_form', '1.4.2'

group :assets do
  gem 'sass-rails', ' ~> 3.1.0.rc'
  gem 'coffee-rails', '~> 3.1.0.rc'
  gem 'uglifier', '1.0.1'
end

gem 'rspec-rails', '2.6.1', :group => [:test, :development]

group :development do
  gem 'capistrano', '2.8.0'
  gem 'active_reload', '0.3.0'
  gem 'passenger', '3.0.8'
end

group :test do
  gem 'database_cleaner', '0.6.7'
  gem 'ffaker', '1.8.0'
  gem 'machinist', '2.0.0.beta2'
  gem 'capybara', '1.0.1'
  gem 'guard-rspec', '0.4.2'
  gem 'guard-bundler', '0.1.3'

  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent', '0.4.1'
    gem 'growl', '1.0.3'
  end

  if RUBY_PLATFORM.downcase.include?("linux")
    gem 'rb-inotify', '0.8.6'
    gem 'libnotify', '0.5.7'
  end
end

group :production do
  gem 'exception_notification', '2.4.1'
end

