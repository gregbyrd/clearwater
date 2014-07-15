class Season < ActiveRecord::Base
  has_many :fish_dates
  validates :start_month, numericality: {greater_than: 0, less_than: 13}
  validates :end_month, numericality: {greater_than: 0, less_than: 13}
  validates :year, numericality: {greater_than: 0}
  validates :slot_limit, numericality: {greater_than: 0}

  def start_date
    Date.new(year, start_month)
  end
  def end_date
    if end_month >= start_month
      Date.new(year, end_month, -1)
    else
      Date.new(year+1, end_month, -1)
    end
  end

  def in_season?(date)
    date >= start_date && date <= end_date
  end
  
  def name
    if end_month <= start_month
      "#{year}-#{(year+1)%100}"
    else
      "#{year}"
    end
  end

end
