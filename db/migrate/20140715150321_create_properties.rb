class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :current_season_id

      t.timestamps
    end
  end
end
