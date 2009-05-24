# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_seed16_session',
  :secret      => 'c3fc2f47555aaec309d31ec77a35cf11bcd5b649642053ff8dc6842a3ad36c1193f4dafc1b855a113d99f029b24863da42bfcbee3e5769cf2d402411d8eb5586'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
