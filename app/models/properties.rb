# This is an object that holds global properties for the
# system.  Initially, it only has one field for the 
# ID of the current season.  Can only be written by admin.


class Properties < ActiveRecord::Base
  include ActiveRecord::Singleton
  # attribute is current_season_id

end
