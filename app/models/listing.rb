class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :reservations
	validates :title, presence: true 
	mount_uploaders :avatars, AvatarUploader
	acts_as_taggable # Alias for acts_as_taggable_on :tags
end
