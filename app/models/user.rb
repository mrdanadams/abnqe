class User < ActiveRecord::Base

  serialize :netflix_info

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :netflix_id, :netflix_info

  # Finds or creates a user account for the given netflix user
  def self.find_for_netflix(auth, user)
    netflix_id = auth.uid

    # TODO update the user with info from netflix for existing users?
    unless user = User.where(:netflix_id => netflix_id).first
      info = { 'token' => auth.credentials.token, 'secret' => auth.credentials.secret }.merge(auth.extra.raw_info.user)
      # email and password are required but not used
      user = User.create! netflix_id: netflix_id, netflix_info: info, email: "#{netflix_id}@netflix.com", password: Devise.friendly_token[0,20]
    end

    user
  end
end
