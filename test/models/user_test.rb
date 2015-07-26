require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "unique name" do
    assert users(:joe).save
    dupe = User.new name: "Joe", email: "jose@example.com", password: "blahblahblah"
    assert_not dupe.save, "Duplicate name allowed"
    dupe.name = "Jose"
    assert dupe.save, "Unique names should be allowed #{dupe.errors.messages.inspect}"
  end

  test "blank name is okay, even twice" do
    thing1 = User.new email: "thing1@example.com", password: "blahblahblah"
    thing2 = User.new email: "thing2@example.com", password: "blahblahblah"
    assert_nil thing1.name
    assert_nil thing2.name
    assert thing1.save, "Blank name not allowed #{thing1.errors.messages.inspect}"
    assert thing2.save, "More than one blank name should be allowed #{thing2.errors.messages.inspect}"
  end

  test "has unique email" do
    assert users(:sarah).save
    dupe = User.new name: "Sara", email: "sarah@example.com", password: "blahblahblah"
    assert_not dupe.save, "Duplicate email allowed"
    dupe.email = "sara@example.com"
    assert dupe.save, "Unique emails should be allowed"
  end

  test "auth token generated" do
    User.all.each do |u|
      assert u.save
      assert_not_nil u.authentication_token, "Missing authentication token: #{u.authentication_token}"
    end
  end

  test "owns decks" do
    assert users(:joe).save
    assert_respond_to users(:joe), :decks, "User should have many decks"
  end
end
