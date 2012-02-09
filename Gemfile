source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', '1.3.4', :group => :development
#gem 'mysql2'

gem 'devise', '>= 1.4.9'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'rspec-rails', '2.6.1', :group => [:development, :test] #modified from 2.6.1 to 2.7.0 for Devise
group :development do
    gem 'annotate', 
        :git => 'git://github.com/jeremyolliver/annotate_models.git', 
        :branch => 'rake_compatibility'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'webrat', '0.7.1'
  gem 'spork', '0.9.0.rc8'
  gem 'autotest', '4.4.6'
  gem 'autotest-rails-pure', '4.1.2'
  gem 'autotest-fsevent', '0.2.4'
  gem 'autotest-growl', '0.2.9'
	gem 'factory_girl_rails', '>= 1.3.0'
	gem 'cucumber-rails', '>= 1.1.1'
	gem 'capybara', '>= 1.1.1'
	gem 'database_cleaner', '>= 0.6.7'
	gem 'launchy', '>=2.0.5'
end
