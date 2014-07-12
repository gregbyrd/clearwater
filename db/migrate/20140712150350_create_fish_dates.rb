class CreateFishDates < ActiveRecord::Migration
  def change
    create_table :fish_dates do |t|
      t.date :day
      t.references :season_id, index: true

      t.timestamps
    end
  end
end
