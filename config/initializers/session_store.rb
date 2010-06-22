# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rolodex_session',
  :secret      => 'c5e817f52475a1075527466e469d6257fb198b5c6701e707ae254c6afd0f0ea35ba91487f571fce29664346036d28899ef0ed63999b9b03f0d56db75afc7b6d5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
