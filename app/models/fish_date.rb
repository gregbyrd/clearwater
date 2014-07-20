class FishDate < ActiveRecord::Base
  belongs_to :season
  validates_presence_of :season_id
  has_many :slots
  validates_presence_of :day
  validates_numericality_of :slot_limit
  validate :day_in_season?

  def fully_booked?(force=false)
    available(force) <= 0
  end
  def available(force=false)
    reload if force
    slot_limit - slots.count
  end

  def print_num
    day.to_s
  end
  def print_full
    day.strftime("%b %-d, %Y (%A)")
  end
  def print_short
    day.strftime("%b %-d")
  end

  def day_in_season?
    if (season && !season.in_season?(day))
      errors.add(:day, 'must be a valid date') 
    end
  end
end
