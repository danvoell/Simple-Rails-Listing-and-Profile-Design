class Post < ActiveRecord::Base
  attr_accessible :description, :picture, :subheading, :title, :image, :remote_image_url, :tag_list
  mount_uploader :image, ImageUploader
	acts_as_taggable
has_reputation :votes, source: :user, aggregated_by: :sum
has_many :comments, as: :commentable

def to_param
"#{id}-#{title}".parameterize
end

end