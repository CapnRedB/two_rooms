class User < ActiveRecord::Base
  PLACEHOLDER = 'name@example.com'
  PLACEHOLDER_REGEX = /name@example.com/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  validates_uniqueness_of :email
  validates_uniqueness_of :name
  before_save :ensure_authentication_token

  has_many :decks

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user
    
    if user.nil?

      #twitter
      email = auth.info.email
      user = User.where(email: email).first if email
      name = auth.info.name

      if user.nil?
        user = User.new(
          name: name,
          email: email ? email : "oauth-#{name}@#{auth.provider}.com",
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

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def is_admin?
    false
  end

  private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
