class Season < ActiveRecord::Base
  has_many :fish_dates
  validates :start_month, numericality: {greater_than: 0, less_than: 13}
  validates :end_month, numericality: {greater_than: 0, less_than: 13}
  validates :year, numericality: true
  validates :slot_limit, numericality: true

end
