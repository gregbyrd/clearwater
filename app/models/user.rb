class User < ActiveRecord::Base
  has_secure_password

  has_many :slots
  has_many :fish_dates, through: :slots
  validates_presence_of :password_digest
  validates_presence_of :admin
  validates :email, presence: true, uniqueness: {case_sensitive: false} 
  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  serialize :guests, Array

end
