# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MySite::Application.initialize!

MySite::Application.assets.append_path('app/assets/javascripts')
