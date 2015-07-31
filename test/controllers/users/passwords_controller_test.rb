# require 'test_helper'

# class Users::PasswordsControllerTest < ActionController::TestCase
#   setup do
#     @user = users(:joe)
#   end

#   #create seems to be used for recovery, if you think about a password as it's own object
#   # a `new` password seems appropriate for this, whereas changing a password you knew
#   # is an edit/update

#   test "can change password" do
#     logged_in

#     users(:joe).save
#     old_hash = users(:joe).encrypted_password

#     post :update, password: { password: "banana", password_confirmation: "banana" }
#     p @response
#     p @response.status

#     p old_hash
#     p users(:joe).encrypted_password
#     assert_response :success, "password change should succeed"
#     assert_not_equal old_hash, users(:joe).encrypted_password, "Password hash should be different"
#     assert @controller.current_user, "Still logged in"
#   end

#   test "does not require confirmation" do

#   end

#   test "you need to be logged in to change password" do
#   end

#   test "password change is effective" do 
#   end

# end

# # POST/PUT/PATCH /users/password.json   #create #update