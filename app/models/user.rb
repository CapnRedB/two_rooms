class User < ActiveRecord::Base
  PLACEHOLDER = 'name@example.com'
  PLACEHOLDER_REGEX = /name@example.com/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable


  validates_format_of :email, :without => PLACEHOLDER_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user
    
    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(email: email).first if email

      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{PLACEHOLDER}-#{auth.id}-#{auth.provider}.com",
          password: Devise.friendly_token[0, 20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    if identity.user != user
      identiy.user = user
      identiy.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ PLACEHOLDER_REGEX
  end
  
end
