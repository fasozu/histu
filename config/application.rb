require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Histu
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Set how many tries it do to generate a random code before give up
    config.short_code_generator_max_tries = 10 

    # Set max probability a random code generated will 
    # collide with a code generated before  (1=100%). This takes in 
    # account the total urls in database
    config.short_code_generator_max_probability_repeated = 0.0001 
    
    #List of char available to generate random codes
    config.short_code_generator_char_options = ('a'..'z').to_a+('A'..'Z').to_a+('0'..'9').to_a 

    

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
