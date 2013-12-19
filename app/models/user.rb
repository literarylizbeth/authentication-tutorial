class User < ActiveRecord::Base

  validates :email, presence: true

  has_secure_password

  before_save { self.email = email.downcase }

end
