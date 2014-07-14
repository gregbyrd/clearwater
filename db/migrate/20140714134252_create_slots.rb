class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.references :fish_date, index: true
      t.references :user, index: true
      t.string :label

      t.timestamps
    end
  end
end
