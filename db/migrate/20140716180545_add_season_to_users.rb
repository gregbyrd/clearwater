class AddSeasonToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :season, index:true
  end
end
