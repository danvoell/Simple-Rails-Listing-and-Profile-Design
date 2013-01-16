class User < ActiveRecord::Base
  after_create :send_welcome_email 

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes, :username, :image
  # attr_accessible :title, :body

  has_one :profile
  accepts_nested_attributes_for :profile
  has_many :posts

   has_and_belongs_to_many :roles
 mount_uploader :image, ImageUploader

def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def has_role?(role_sym)
  roles.any? { |r| r.name.underscore.to_sym == role_sym }
end

private

    def send_welcome_email
      UserMailer.deliver_welcome_email(self)
    end

end
