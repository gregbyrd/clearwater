class FishDate < ActiveRecord::Base
  belongs_to :season
  validates_presence_of :season_id
  has_many :slots
  validate :day_is_date?

  def day_is_date?
    if ((DateTime.parse(day) rescue ArgumentError) == ArgumentError)
      errors.add(:day, 'must be a valid date') 
    end
  end
end
