class FishDate < ActiveRecord::Base
  belongs_to :season
  validates_presence_of :season_id
  has_many :slots
  validates_presence_of :day
  validate :day_in_season?
  

  def day_in_season?
    if (season && !season.in_season?(day))
      errors.add(:day, 'must be a valid date') 
    end
  end
end
