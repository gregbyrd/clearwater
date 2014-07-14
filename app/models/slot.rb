class Slot < ActiveRecord::Base
  belongs_to :fish_date
  belongs_to :user
  validates_presence_of :label
end
