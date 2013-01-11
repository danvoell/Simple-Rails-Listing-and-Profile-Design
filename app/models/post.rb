class Post < ActiveRecord::Base
  attr_accessible :description, :picture, :subheading, :title, :image, :remote_image_url
  mount_uploader :image, ImageUploader

def to_param
"#{id}-#{title}".parameterize
end

end