class Post < ActiveRecord::Base
  attr_accessible :description, :picture, :subheading, :title
end
