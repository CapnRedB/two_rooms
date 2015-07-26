require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "unique name" do

  end

  test "blank name is okay, even twice" do

  end

  test "has unique email" do

  end

  test "auth token generated" do
    User.all.each do |u|
      u.save!
      assert_not_nil u.authentication_token, "Missing authentication token: #{u.authentication_token}"
    end
  end


end
