class User < ActiveRecord::Base
  PLACEHOLDER = 'name@example.com'
  PLACEHOLDER_REGEX = /name@example.com/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user
    
    p auth
    if user.nil?
      email = auth.info.email
      user = User.where(email: email).first if email
      name = auth.info.name
      nickname = auth.info.nickname || auth.info.name

      if user.nil?
        user = User.new(
          name: name,
          #nickname: nickame,
          email: email ? email : "oauth-#{nickname}@#{auth.provider}.com",
          password: Devise.friendly_token[0, 20]
        )
        user.skip_confirmation! if user.respond_to?(:skip_confirmation)
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  # def email_verified?
  #   self.email && self.email !~ PLACEHOLDER_REGEX
  # end

end
