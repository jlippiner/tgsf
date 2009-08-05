# == Schema Information
# Schema version: 20090620001551
#
# Table name: presses
#
#  id            :integer(4)      not null, primary key
#  item          :string(255)
#  source        :string(255)
#  story_date_at :date
#  link          :string(255)
#  comment       :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Press < ActiveRecord::Base
end
