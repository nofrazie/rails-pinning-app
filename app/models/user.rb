class User < ActiveRecord::Base
  has_secure_password

  has_many :pins

  validates_presence_of :first_name, :last_name, :email, :password

  validates_uniqueness_of :email
end
