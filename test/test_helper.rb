ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

end

class ActionController::TestCase < ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  include Devise::TestHelpers

  def for_users
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
  def logged_in
    for_users
    sign_in users(:joe)
  end

  def logged_in?
    !! current_user
  end


  # def logged_out
  #   @request.env["devise.mapping"] = Devise.mappings[:user]
  #   sign_out :user
  # end
end
