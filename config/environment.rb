RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "authlogic"
  config.gem "paperclip"
  config.gem 'vpim'


  config.time_zone = 'UTC'

end