ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::TestHelpers

end

class ActionController::TestCase < ActiveSupport::TestCase

  def logged_in
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in users(:joe)
  end
end
