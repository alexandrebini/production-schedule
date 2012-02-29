source 'http://rubygems.org'

gem 'rake', '0.9.2.2'
gem 'rails', '3.2.1'
gem 'mysql2', '0.3.11'

gem 'haml', '3.1.4'
gem 'sass-rails', '3.2.4'
gem 'compass', '0.11.7'
gem 'coffee-rails', '3.2.2'
gem 'jquery-rails', '2.0.1'
gem 'simple_form', '2.0.1'

group :assets do
  gem 'uglifier', '1.2.3'
end

gem 'rspec-rails', '2.8.1', :group => [:test, :development]

group :development do
  gem 'capistrano', '2.11.2'
  gem 'passenger', '3.0.11'
  gem 'ruby-prof', '0.10.8'
end

group :test do
  gem 'spork', '0.9.0'
  gem 'database_cleaner', '0.7.1'
  gem 'ffaker', '1.13.0'
  gem 'fabrication', '1.3.2'
  gem 'guard-rspec', '0.6.0'
  gem 'guard-bundler', '0.1.3'
  gem 'guard-spork', '0.5.2'
  gem 'guard-migrate', '0.0.2'

  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent', '0.9.0'
    gem 'growl', '1.0.3'
  end

  if RUBY_PLATFORM.downcase.include?("linux")
    gem 'rb-inotify', '0.8.6'
    gem 'libnotify', '0.5.7'
  end
end

group :production do
  gem 'exception_notification', '2.5.2'
end