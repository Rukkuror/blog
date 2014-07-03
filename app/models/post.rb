class Post < ActiveRecord::Base
  has_many :categorizations
  has_many :tags, :through => :categorizations
  mount_uploader :avatar, AvatarUploader
end
