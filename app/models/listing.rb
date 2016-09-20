class Listing < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true 
	mount_uploaders :avatars, AvatarUploader
end
