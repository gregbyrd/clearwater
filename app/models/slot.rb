class Slot < ActiveRecord::Base
  belongs_to :fish_date
  belongs_to :user
  validates_presence_of :label

  def owner
    if !user
      ''
    else
      namestr = user.name
      namestr = user.email if namestr == ''
      if label == "self"
        namestr
      else
        label + ' (Guest of: ' + namestr + ')'
      end
    end
  end

end
