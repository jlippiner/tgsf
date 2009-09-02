# == Schema Information
#
# Table name: followers
#
#  id          :integer(4)      not null, primary key
#  screen_name :string(255)
#  friend_id   :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Follower < ActiveRecord::Base
end
