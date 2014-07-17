class User < ActiveRecord::Base
  has_secure_password

  # every user belongs to a season, except for admin users
  belongs_to :season

  has_many :slots
  has_many :fish_dates, through: :slots
  validates_presence_of :password_digest
  validates :admin, inclusion: { in: [true, false] }
  validates :email, presence: true, uniqueness: {case_sensitive: false} 
  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  serialize :guests, Array

  def name
    @name ||= create_name
  end

  def create_name
    if firstname && lastname
      [ firstname, lastname ].reject(&:empty?).join(' ')
    else
      firstname || lastname || ''
    end
  end

  def used
    slots.count
  end
  

end
