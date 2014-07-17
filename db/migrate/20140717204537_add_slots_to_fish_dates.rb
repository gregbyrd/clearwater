class AddSlotsToFishDates < ActiveRecord::Migration
  def change
    add_column :fish_dates, :slot_limit, :integer
  end
end
