ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.


  # Add more helper methods to be used by all tests here...

  def log_in_as(user)
    session[:user_id] = user.id
  end

  def sign_in_as(user, password)
   post login_path, session: {email: user.email, password: password}
  end
end

class ActionDispatch::IntegrationTest
  def log_in_as(user, password: 'password', remember_me: '1')
    post(login_path, params: { session: { email: user.email, password: password,
                                          remember_me: remember_me } } )
  end
end
