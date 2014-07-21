class User < ActiveRecord::Base
  has_secure_password

  # every user belongs to a season, except for admin users
  belongs_to :season

  has_many :slots
  has_many :fish_dates, through: :slots
  validates_presence_of :password_digest
  validates :admin, inclusion: { in: [true, false] }
  validates_presence_of :email
  validates_format_of :email, 
     with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  with_options unless: :admin? do |user|
    user.validates_presence_of :season_id
    user.validates_uniqueness_of :email, scope: :season_id,
          message: 'matches an existing user within the season.'
  end
  with_options if: :admin? do |user|
    user.validates_uniqueness_of :email,
          message: 'matches an existing admin user.'
  end
  
  serialize :guests, Array

  def name
    fullname || email
  end

  def fullname
    @fullname = create_name
  end

  def create_name
    if firstname && lastname
      [ firstname, lastname ].reject(&:empty?).join(' ')
    else
      firstname || lastname 
    end
  end

  def used
    slots.count
  end
  def available
    purchased - slots.count
  end

  def fully_booked?
    slots.count >= purchased
  end

end
