# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_vd2_session',
  :secret      => 'ca326aab087702bacd2ffcf5e42edd2602ce7de076bc03f6104c5056571159d74b10e097d31a2a27a8255e0e2c8db171346d6000d50d5363bfb03ddc34ca128f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
