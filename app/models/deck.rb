class Deck < ActiveRecord::Base
  belongs_to :user

  def user_name
    unless user.nil?
      user.name
    else
      "Anonymous"
    end
  end
end
