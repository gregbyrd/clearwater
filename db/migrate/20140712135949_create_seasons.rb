class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :year
      t.integer :start_month
      t.integer :end_month
      t.integer :slot_limit

      t.timestamps
    end
  end
end
