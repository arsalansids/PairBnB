class User < ActiveRecord::Base
  include Clearance::User

  # include Clearance::User

   has_many :authentications, :dependent => :destroy
   has_many :listings 
   has_many :reservations
   
  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      # u.first_name = auth_hash["info"]["first_name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.password = rand(1..9)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
  mount_uploaders :avatars, AvatarUploader
end



#   include Clearance::User
# end

