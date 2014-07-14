class User < ActiveRecord::Base
  has_many :slots
  has_many :fish_dates, through: :slots
  validates_presence_of :email, :password_digest, :admin
  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  serialize :guests, Array

end
