class Slot < ActiveRecord::Base
  belongs_to :fish_date
  belongs_to :user
  validates_presence_of :label

  def owner
    if !user
      ''
    else
      namestr = user.name
      if label == "self"
        namestr
      else
        label + ' (Guest of: ' + namestr + ')'
      end
    end
  end
  def guest
    if !user || label == 'self'
      ''
    else
      label
    end
  end

end
