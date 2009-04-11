# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nested_test_session',
  :secret      => 'e8028e9712bd3f213182c4ecb653ad17ca66a4b1dbed8d382f976ee07730b2274dd2f9a0eba82416d7244666e38315b4d52ca91602395400fbf7780d3705f9b2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
